exports.replaceLastOccurrence = (str, pattern, replacement) ->
  return str unless str?.length

  index = str.lastIndexOf(pattern)
  if index >= 0
    firstHalf = str.substring(0, index)
    secondHalf = str.substring(index + pattern.length)
    "#{firstHalf}#{replacement}#{secondHalf}"
  else
    str

exports.escapeQuotes = (str) -> str.replace(/"/g, "\\\"")
exports.unescapeQuotes = (str) -> str.replace(/\\"/g, "\"")
exports.stripQuotes = (str) -> str.replace(/^(["'])(.+)\1$/g, "$2")

exports.extractAllMatches = (str, regex, groups...) ->
  result = []
  while matches = regex.exec(str)
    if matches?.length
      if groups.length
        for group in groups
          result.push matches[group] if matches[group]
      else
        result.push matches[0]
  result
