_ = require 'lodash'
{Compiler} = require 'jade'
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

class Yudi extends Compiler
  constructor: (node, options) ->
    Compiler.call(this, arguments...)
    @strings = []
    @attrsWhitelist = options.attrs ? []
    @postCompile = options.postCompile

  compile: ->
    result = super()
    @postCompile?(this)
    result

  checkAlreadyWrapped: (str) ->
    wrapped = isAlreadyWrapped(str)
    if wrapped
      matches = wrappedString.exec(str)
      if matches?.length
        @strings.push(unescapeQuotes(match[2]))
    wrapped

  visitAttributes: (attrs, attributeBlocks) ->
    _.chain attrs
      .filter (attr) => attr.name in @attrsWhitelist
      .each (attr) =>
        trimmed = attr.val.trim()
        if not @checkAlreadyWrapped(trimmed)
          if attr.escaped
            @strings.push(stripQuotes(trimmed))
          wrapped = tokenTransforms.attr.internationalize(trimmed)
          attr.val = wrapped

    super attrs, attributeBlocks

  visitCode: (code) ->
    matches = extractAllMatches(code.val, wrappedStringInCode, 2)
    _.each matches, (match) =>
      @strings.push match
    if code.buffer
      code.val = tokenTransforms.code.internationalize(code.val)
    super code

  visitText: (text) ->
    trimmed = text.val.trim()
    if not @checkAlreadyWrapped(trimmed)
      if not isInterpolationOnly(trimmed) and not ignoreText(trimmed)
        @strings.push(trimmed)
      wrapped = tokenTransforms.text.internationalize(trimmed)
      text.val = text.val.replace(trimmed, wrapped)

    super text

module.exports = Yudi
