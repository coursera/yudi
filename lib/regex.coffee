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
    ([\#!]\{)? # only present for wrapped text tokens (optional, group 1)
      _t\(
        (.+) # translation key (group 2)
      \)
    (\})? # only present for wrapped text tokens (optional, group 3)
  ///g

  wrappedString: ///
    # ^\s*
    ([\#!]\{)? # only present for wrapped text tokens (optional, group 1)
      _t\(
        (["'])
          (.+) # key string (group 3)
        \2
        (,\s\{.+\})? # interpolation hash (optional, group 4)
      \)
    (\})? # only present for wrapped text tokens
    (\s|&nbsp;)*$ # trailing space
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