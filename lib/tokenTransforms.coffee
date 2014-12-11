{
  escapeQuotes
  unescapeQuotes
} = require './util'
{
  interpolation
  wrappedString
  wrappedAnything
  isStringLiteral
  containsHtml
  containsHtmlEntity
  isInterpolationOnly
  isWrappedInterpolationOnly
  ignoreText
} = require './regex'

selectEscapeSymbol = (s) ->
  if s.indexOf('!{') >= 0 or containsHtml(s) or containsHtmlEntity(s) then '!' else '#'

stringifyInterpolations = (str) ->
  interpolations = []
  match = interpolation.exec(str)
  while match
    interpolations.push(match[1])
    match = interpolation.exec(str)
  keys = ("\"#{escapeQuotes(interp)}\":_t(#{interp})" for interp in interpolations)
  if keys.length then "{#{keys.join(", ")}}" else ""

module.exports =
  attr:
    internationalize: (str) -> if isStringLiteral(str) then "_t(#{str})" else str
    uninternationalize: (str) -> str.replace(wrappedAnything, '$1')

  code:
    internationalize: (str) -> if str then "_t(#{str})" else str
    uninternationalize: (str) -> str.replace(wrappedAnything, '$1')

  text:
    internationalize: (str) ->
      return str if ignoreText(str)

      escaped = escapeQuotes(str)
      esc = selectEscapeSymbol(str)

      if isInterpolationOnly(str)
        str.replace(/[!#]{/, "#{esc}{_t(").replace('}', ')}')
      else
        interpolations = stringifyInterpolations(str)
        if interpolations?.length
          "#{esc}{_t(\"#{escaped}\", #{interpolations})}"
        else
          "#{esc}{_t(\"#{escaped}\")}"

    uninternationalize: (str) ->
      if isWrappedInterpolationOnly(str)
        str.replace('{_t(', '{').replace(')}', '}')
      else
        str = str.replace(wrappedString, '$2$3').replace(wrappedAnything, '$1')
        unescapeQuotes(str)
