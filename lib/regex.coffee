testRegex = (regex) -> (s) -> regex.test(s)

module.exports = {

  interpolation: ///
    [\#!] # escape
    \{
      ([^}]+?) # {interpolation} (non greedy)
    \}
  ///g
  wrappedStringInCode: ///
    _t\(
      (["'])
        (.+?) # key string (non greedy, group 2)
      \1
    \)
  ///g
  wrappedAnything: ///
    (?:[\#!]\{)? # only present for wrapped text tokens
      _t\(
        (.+) # translation key (group 1)
      \)
    (?:\})? # only present for wrapped text tokens
  ///g

  wrappedString: ///
    (?:[\#!]\{)? # only present for wrapped text tokens
      _t\(
        (["']) # quote (group 1)
          (.+) # key string (group 2)
        \1
        (?:,\s\{.+\})? # interpolation hash
      \)
    (?:\})? # only present for wrapped text tokens
    ((?:\s|&nbsp;)*)$ # trailing space (group 3)
  ///
  ignoreText: testRegex ///
    ^
    (
      [\W\d_]  # symbol or numbers
      |       # or
      &[^;]+; # html entities
    )* # 0 or more, so including empty strings
    $
  ///
  isStringLiteral: testRegex /^\s*(["']).+\1\s*$/

  isAlreadyWrapped: testRegex /_t\(/
  containsHtml: testRegex /<[^>]+>/
  containsHtmlEntity: testRegex /&[^;]+;/
  isInterpolationOnly: testRegex ///
    ^[\W\d_]*
    [\#!]\{
      [^}]+ # {interpolation}
    \}
    [\W\d_]*$
  ///
  isWrappedInterpolationOnly: testRegex ///
    ^[\W\d_]*
    [\#!]\{_t\(
      (?!["']) # not a string translation key
      .+ # {interpolation}
    \)\}
    [\W\d_]*$
  ///
}