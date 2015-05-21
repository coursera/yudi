_ = require 'lodash'
tokenTransforms = require './tokenTransforms'
{
  isAlreadyWrapped
  isInterpolationOnly
  wrappedString
  wrappedStringInCode
  ignoreText
  isStringLiteral
} = require './regex'
{
  unescapeQuotes
  extractAllMatches
  stripQuotes
} = require './util'

lex = require 'jade-lexer'
parse = require 'jade-parser'
walk = require 'jade-walk'
generate = require 'jade-generator'

module.exports = (content, options = {}) ->
  ast = parse(lex(content, options?.filename))

  strings = []
  attrsWhitelist = options.attrs ? []

  checkAlreadyWrapped = (str) ->
    wrapped = isAlreadyWrapped(str)
    if wrapped
      matches = wrappedString.exec(str)
      if matches?.length
        strings.push(unescapeQuotes(matches[2]))
    wrapped

  transformAttributes = (attrs) ->
    _.chain attrs
      .filter (attr) -> attr.name in attrsWhitelist
      .each (attr) ->
        trimmed = attr.val.trim()
        if not checkAlreadyWrapped(trimmed)
          if attr.escaped
            strings.push(stripQuotes(trimmed))
          wrapped = tokenTransforms.attr.internationalize(trimmed)
          attr.val = wrapped

  transformCode = (code) ->
    console.log code
    matches = extractAllMatches(code.val, wrappedStringInCode, 2)
    if matches?.length
      strings = strings.concat(matches)
    if code.buffer
      code.val = tokenTransforms.code.internationalize(code.val)

  transformText = (text) ->
    trimmed = text.val.trim()
    if not checkAlreadyWrapped(trimmed)
      if not isInterpolationOnly(trimmed) and not ignoreText(trimmed)
        strings.push(trimmed)
      wrapped = tokenTransforms.text.internationalize(trimmed)
      text.val = text.val.replace(trimmed, wrapped)

  transformMixin = (mixin) ->
    if mixin.args? and mixin.call
      matches = extractAllMatches(mixin.args, wrappedStringInCode, 2)
      if matches?.length
        strings = strings.concat(matches)

  walk ast, (node, replace) ->
    if node.attrs?.length
      transformAttributes(node.attrs)

    if node.attributeBlocks?.length
      transformAttributes(node.attributeBlocks)

    if node.type is 'Code'
      transformCode(node)
    else if node.type is 'Text'
      transformText(node)
    else if node.type is 'Mixin'
      transformMixin(node)
    else if node.code
      console.log 'aoeustnh'
      console.log node
      transformCode(node.code)

  source = generate(ast, options)

  console.log strings
  {source, strings}
