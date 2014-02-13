_ = require("lodash")
Lexer = require("jade").Lexer

indexOf = (lines, pattern, start) ->
  for line, i in lines[start..]
    return start + i if line.indexOf(pattern) >= 0
  return -1

getTokens = (source) ->
  lexer = new Lexer(source)
  tokens = []
  token = lexer.advance()
  while token?.type isnt "eos"
    # jade linenumbers are 1 based
    token.line -= 1
    tokens.push token
    token = lexer.advance()
  tokens

extractAttrs = (token, attrs = []) ->
  _.chain(token.attrs)
  .filter((attr) -> _.contains(attrs, attr.name))
  .map(({name, val}) -> {type: "attr", line: token.line, name, val})
  .value()

selectType = (tokens, type) ->
  _.filter(tokens, (token) -> token.type is type)

selectAttrs = (tokens, attrs) ->
  _.chain(tokens)
    .filter((token) -> token.type is "attrs" and not _.isEmpty(token.attrs))
    .map((token) -> extractAttrs(token, attrs))
    .flatten()
    .value()

getTranslatableTokens = (source, options = {}) ->
  lines = source.split("\n")
  tokens = getTokens(source)

  texts = selectType(tokens, "text")
  codes = selectType(tokens, "code")
  textAttrs = selectAttrs(tokens, options.attrs)

  # correct text attr line numbers since multilined attributes will all
  # correspond to the same line due to the Lexer
  for attr, i in textAttrs
    line = lines[attr.line]
    if line.indexOf(attr.name) < 0
      attr.line = indexOf(lines, attr.name, attr.line)

  _.sortBy(texts.concat(textAttrs).concat(codes), "line")

module.exports = {getTokens, getTranslatableTokens}