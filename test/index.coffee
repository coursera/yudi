_ = require("lodash")
fs = require("fs")
requirejs = require("requirejs")
{expect} = require("chai")

getTranslatableTokens = require("../lib/tokens")
{internationalize, uninternationalize} = require("../lib")
{
  isAlreadyWrapped
  wrappedString
  wrappedStringInCode
} = require("../lib/regex")
{
  stripQuotes
  escapeQuotes
  unescapeQuotes
  removePlaceholder_t
  extractAllMatches
} = require("../lib/util")

describe "(un)internationalize", ->
  before (done) ->
    fs.readFile "#{__dirname}/jade/test.jade", "utf-8", (e, d) =>
      @jadeSource = d
      @lines = (@jadeSource ? "").split("\n")
      @options =
        tokens: true
        attrs: [
          "data-default-message"
          "data-inflight-message"
          "data-success-message"
          "data-form-error"
          "data-form-correct"
          "data-tooltip"
          "placeholder"
        ]
      @i18nResult = internationalize(@jadeSource, @options)
      @i18nResult2 = internationalize(@i18nResult.source, @options)
      @bundle = requirejs("#{__dirname}/jade/nls/root/test.jade.js")
      done(e)

  it "internationalize result of the original source and internationalize result of the internationalized source shoud be the same", ->
    expect(@i18nResult).to.deep.equal @i18nResult2

  it "internationalized source with or without the tokens options should be the same", ->
    expect(@i18nResult.source).to.equal internationalize(@jadeSource, _.omit(@options, 'tokens'))

  it "internationalized result tokens should match the nls bundle", ->
    expected = _.keys(@bundle).sort()
    actual = _.chain(@i18nResult.tokens).pluck('val').unique().sort().value()
    actual2 = _.chain(@i18nResult2.tokens).pluck('val').unique().sort().value()
    expect(actual).to.deep.equal expected
    expect(actual2).to.deep.equal expected

  it "internationalized tokens should have correct line numbers", ->
    resultLines = @i18nResult.source.split("\n")
    for token in @i18nResult.tokens
      {line, type, val} = token
      if isAlreadyWrapped(@lines[line]) and type isnt "code"
        expect(@lines[line]).to.contain escapeQuotes(val)
      else
        expect(@lines[line]).to.contain val

      if type is "code"
        expect(resultLines[line]).to.contain unescapeQuotes(val)
      else
        expect(resultLines[line]).to.contain escapeQuotes(val)

  it "translation keys collected from an internationalized source and from an uninternationalized files should be identical", ->
    wrappedTranslationKeys = []
    for token in getTranslatableTokens(@i18nResult.source, @options)
      if token.type isnt "code" and isAlreadyWrapped(token.val)
        matches = wrappedString.exec(token.val)
        wrappedTranslationKeys.push unescapeQuotes(matches[3]) if matches?.length
      if token.type is "code"
        matches = extractAllMatches(token.val, wrappedStringInCode, 2)
        wrappedTranslationKeys = wrappedTranslationKeys.concat(matches)

    collectedTranslationKeys = _.pluck(@i18nResult.tokens, "val")
    expect(collectedTranslationKeys).to.deep.equal wrappedTranslationKeys

  it "uninternationalize(internationalize(str)) should equal str", ->
    str = uninternationalize(@i18nResult.source, @options)
    expect(@jadeSource).to.equal str