_ = require("lodash")
tokenTransforms = require("./tokenTransforms")
{getTranslatableTokens} = require("./tokens")
{
  isAlreadyWrapped
  isInterpolationOnly
  wrappedString
  wrappedStringInCode
  ignoreText
  isDoubleQuotedString
} = require("./regex")
{
  replaceLastOccurrence
  unescapeQuotes
  extractAllMatches
  stripQuotes
} = require("./util")

internationalize = (source, options = {}) ->
  lines = source.split("\n")
  tokens = getTranslatableTokens(source, options)
  internationalized = []

  for token in tokens
    # using trimmed to do wrapping and then replacements in order to preserve
    # whitespace so the string transformation doesn't have to deal with it
    trimmed = token.val.trim()
    currentLine = lines[token.line]

    if token.type is "code"
      # collect any _t wrapped raw strings in escaped js code
      matches = extractAllMatches(token.val, wrappedStringInCode, 2)
      _.each matches, (match) ->
        internationalized.push {line: token.line, type: token.type, val: match }
    else if isAlreadyWrapped(trimmed)
      matches = wrappedString.exec(trimmed)
      if matches?.length
        internationalized.push {
          line: token.line
          type: token.type
          val: unescapeQuotes(matches[2])
        }
    else
      record = false

      if token.type is "text"
        record = !isInterpolationOnly(trimmed) and !ignoreText(trimmed)
        wrapped = tokenTransforms.text.internationalize(trimmed)
        lines[token.line] = replaceLastOccurrence(currentLine, trimmed, wrapped)

      if token.type is "attr"
        record = isDoubleQuotedString(trimmed)
        wrapped = tokenTransforms.attr.internationalize(trimmed)
        # assuming there are no spaces between the attr name and the value
        lines[token.line] = currentLine.replace("#{token.name}=#{trimmed}", "#{token.name}=#{wrapped}")

      if record
        internationalized.push {
          line: token.line
          type: token.type
          val: stripQuotes(trimmed)
        }

  source = lines.join("\n")
  if options.tokens?
    return {tokens: internationalized, source}
  else
    return source

uninternationalize = (source, options) ->
  lines = source.split("\n")
  tokens = getTranslatableTokens(source, options)
  for token in tokens
    trimmed = token.val.trim()
    line = lines[token.line]
    if token.type is "text"
      unwrapped = tokenTransforms.text.uninternationalize(trimmed)
      lines[token.line] = replaceLastOccurrence(line, trimmed, unwrapped)
    if token.type is "attr"
      unwrapped = tokenTransforms.attr.uninternationalize(trimmed)
      lines[token.line] = line.replace(trimmed, unwrapped)

  return lines.join("\n")

module.exports = {internationalize, uninternationalize}
