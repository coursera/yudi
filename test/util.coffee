_ = require("lodash")
{expect} = require("chai")

util = require("../lib/util")

randInt = (n) -> Math.ceil(Math.random() * n)
randStr = (l) -> Math.random().toString(35).slice(-l)
randArr = -> _.map(_.range(randInt(10)), -> randStr(randInt(10)))

describe "Utility Functions", ->

  describe "replaceLastOccurrence", ->
    it "should handle invalid input", ->
      expect(util.replaceLastOccurrence(null)).to.equal(null)
      expect(util.replaceLastOccurrence(undefined)).to.equal(undefined)
      expect(util.replaceLastOccurrence("")).to.equal("")
      expect(util.replaceLastOccurrence("", "", "")).to.equal("")

    it "should perform replacements correctly", ->
      replace = (str, pattern, replacement) -> str.replace(pattern, replacement)
      args = ["abcdefg", "def", "xyz"]
      expect(util.replaceLastOccurrence(args...)).to.equal(replace(args...))

    it "should only replace the last occurrence", ->
      str = '''
        button(type="submit",
          data-default-message="Change Password",
          data-success-message="Changed!") Change Password
      '''
      replaced = '''
        button(type="submit",
          data-default-message="Change Password",
          data-success-message="Changed!") #{_t("Change Password")}
      '''
      pattern = "Change Password"
      replacement = '#{_t("' + pattern + '")}'
      expect(util.replaceLastOccurrence(str, pattern, replacement))
        .to.equal(replaced)

  describe "escapeQuotes and unescapeQuotes", ->
    noQuotes = "string without quotes"
    singleQuotes = "string with 'single' quotes"
    doubleQuotes = 'string with "double" quotes'
    escapedDoubleQuotes = 'string with \\"double\\" quotes'

    it "should escape quotes in strings correctly", ->
      check = (str, escaped = str) ->
        expect(util.escapeQuotes(str)).to.equal(escaped)
      check(noQuotes)
      check(singleQuotes)
      check(doubleQuotes, escapedDoubleQuotes)

    it "should unescape quotes in strings correctly", ->
      check = (str, escaped = str) ->
        expect(util.unescapeQuotes(escaped)).to.equal(str)
      check(noQuotes)
      check(singleQuotes)
      check(doubleQuotes, escapedDoubleQuotes)

    it "escapeQuotes and unescapeQuotes should cancel each other out", ->
      check = (str) ->
        expect(util.unescapeQuotes(util.escapeQuotes(str))).to.equal(str)
      check(noQuotes)
      check(singleQuotes)
      check(doubleQuotes)

  describe "stripQuotes", ->
    check = (str, stripped = str) ->
      expect(util.stripQuotes(str)).to.equal(stripped)
    it "should strip quotes from quoted string", ->
      str = 'quote'
      check "\"#{str}\"", str
    it "should ignore strings without quotes", ->
      check "this is a simple test"
    it "should ignore strings containing quotes", ->
      check "this is a simple test with 'quotes'"
      check 'this is a simple test with "quotes"'

  describe "extractAllMatches", ->
    before ->
      @token = randStr(randInt(10))
      @count = randInt(50) * 2
      @str = _.map(_.range(@count), => @token).join("")

    checkMatches = (matches, count, str) ->
      expect(matches.length).to.equal count
      expect(matches.join("")).to.equal str

    it "should extract all matches of a regex in a string", ->
      regex = new RegExp("#{@token}", 'g')
      checkMatches(util.extractAllMatches(@str, regex), @count, @str)

    it "should be able to extract a single group from each string", ->
      regex = new RegExp("(#{@token})", 'g')
      checkMatches(util.extractAllMatches(@str, regex, 1), @count, @str)

    it "should be able to extract multiple groups from each string", ->
      regex = new RegExp("(#{@token})(#{@token})", 'g')
      checkMatches(util.extractAllMatches(@str, regex, 1, 2), @count, @str)
