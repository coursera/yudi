exports.escapeQuotes = (str) -> str.replace(/"/g, "\\\"")
exports.unescapeQuotes = (str) -> str.replace(/\\"/g, "\"")
exports.stripQuotes = (str) -> str.replace(/^(["'])(.+)\1$/g, '$2')

exports.extractAllMatches = (str, regex, groups...) ->
  result = []
  matches = regex.exec(str)
  while matches?.length
    if groups.length
      for group in groups
        result.push matches[group] if matches[group]
    else
      result.push matches[0]

    matches = regex.exec(str)

  result
