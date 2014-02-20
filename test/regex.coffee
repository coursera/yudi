_ = require("lodash")
{expect} = require("chai")

regex = require("../lib/regex")
{extractAllMatches} = require("../lib/util")

describe "Regular Expressions", ->
  checkMatches = (map, regex, group) ->
    for str, interpolations of map
      matches = extractAllMatches(str, regex, group)
      expect(matches).to.deep.equal interpolations

  it "interpolation", ->
    map =
      "": []
      '#{a}': ["a"]
      '#{a} and #{b}': ["a", "b"]
      '#{a.b()} and #{c + d*e("fff")}': ["a.b()", 'c + d*e("fff")']
    checkMatches(map, regex.interpolation, 1)

  it "wrappedStringInCode", ->
    map =
      "": []
      '_t(a)': []
      '_t(a.c("aoeu"))': []
      '_t("aeo\')': []
      '_t("aeo")': ["aeo"]
      '_t("aeo") and _t(\'aeo\')': ["aeo", "aeo"]
      "var a = {k1: _t(\"t1\"), k2: _t(\'t2\'), k3: _t(\"t3\"), k4: _t(\'t4\'), k5: _t(\"t5\")": ["t1", "t2", "t3", "t4", "t5"]
    checkMatches(map, regex.wrappedStringInCode, 2)

  it "wrappedAnything", ->
    map =
      "": []
      '_t(a)': ["a"]
      '#{_t(a.c("aoeu"))}': ['a.c("aoeu")']
      '_t("aeo\')': ['"aeo\'']
      '!{_t("aeo")}': ['"aeo"']
    checkMatches(map, regex.wrappedAnything, 2)

  checkTrueFalse = (f, strs) ->
    for str in strs
      expect(f(str)).to.be.true

  it "wrappedString", ->
    strs = [
      '_t("aaoeu")'
      '#{_t("aaoeu")}'
      '_t("#{a} and #{b}", {"a":a,"b":b})'
      '#{_t("#{a} and #{b}", {"a":a,"b":b})}'
      '_t("aaoeu") &nbsp;'
      '#{_t("aaoeu")} &nbsp;  '
      '_t("#{a} and #{b}", {"a":a,"b":b}) &nbsp;'
      '#{_t("#{a} and #{b}", {"a":a,"b":b})} &nbsp;  '
    ]
    checkTrueFalse(((s) -> regex.wrappedString.test(s)), strs)

  it "ignoreText", ->
    strs = [
      ""
      "  "
      "!"
      "234"
      "!2324@!@#$%@#}$#{}-_"
      "&nbsp;"
      "&nbsp; &nbsp; @#$!@#}"
      "&nbsp; &nbsp; @#$!@#}  "
      "  &nbsp; &nbsp; @#$!@#}  "
    ]
    checkTrueFalse(regex.ignoreText, strs)

  it "isDoubleQuotedString", ->
    strs = [
      '"s"'
      '"a etu at"'
      '"a etu at"  '
      '   "a etu at"  '
    ]
    checkTrueFalse(regex.isDoubleQuotedString, strs)

  it "isAlreadyWrapped", ->
    strs = [
      '_t("s")'
      '_t("s") + _t("s")'
      '#{_t("s")}'
    ]
    checkTrueFalse(regex.isAlreadyWrapped, strs)

  it "containsHtml", ->
    strs = [
      '<html>'
      '<a href="">a</a>'
      '<a href="">a</a> aoetunsh'
    ]
    checkTrueFalse(regex.containsHtml, strs)

  it "containsHtmlEntity", ->
    strs = [
      '&nbsp;'
      '&nbsp; aoeu &quot;'
    ]
    checkTrueFalse(regex.containsHtmlEntity, strs)

  it "isInterpolationOnly", ->
    strs = [
      '#{var}'
      '#{(function() {})(1)}'
      '  #{var}  '
      '  #{_t(var)}  '
      ' @#$! #{var} '
      ' 324 #{var.ou()} 234'
    ]
    checkTrueFalse(regex.isInterpolationOnly, strs)

  it "isWrappedInterpolationOnly", ->
    strs = [
      '#{_t(var)}'
      '#{_t(function() {})}'
      '  #{_t(var)}  '
      ' @#$! #{_t(var)} '
      ' 324 #{_t(var.ou())} 234'
    ]
    checkTrueFalse(regex.isWrappedInterpolationOnly, strs)
