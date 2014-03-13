_ = require("lodash")
fs = require("fs")
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

readFile = (p) -> fs.readFileSync(p, "utf8")
String::contains = (str) -> @indexOf(str) >= 0

casesPath = "#{__dirname}/jade"
ext = ".uni18n.jade"
cases = fs.readdirSync(casesPath)
  .filter((f) -> f.contains(ext))
  .map((f) -> f.replace(ext, ""))

describe "cases", ->
  cases.forEach (test) ->
    name = test.replace(/[-.]/g, " ")

    filename = "#{casesPath}/#{test}#{ext}"
    i18nPath = "#{casesPath}/#{test}.i18n.jade"
    stringsJsonPath = "#{casesPath}/#{test}.uni18n.json"

    jadeSource = readFile(filename)
    i18nSource = readFile(i18nPath)

    lines = (jadeSource ? "").split("\n")
    options =
      filename: filename
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
    tokens = getTranslatableTokens(jadeSource, {filename})
    i18nResult = internationalize(jadeSource, options)
    i18nResult2 = internationalize(i18nResult.source, options)
    stringsJson = if i18nResult.tokens?.length then JSON.parse(readFile(stringsJsonPath)) else []

    describe name, ->
      describe "getTranslatableTokens", ->

        it "results should not contain attr tokens if attrs list is not passed in through options", ->
          attrsTokens = _.filter(tokens, (token) -> token.type is "attr")
          expect(attrsTokens).to.be.empty

        it "results should not contain attr tokens if no attribute in option.attrs exists", ->
          attrs = ["this-should-not-be-an-attribute", "or-this"]
          attrsTokens = _.filter(getTranslatableTokens(jadeSource, {filename, attrs}), (token) -> token.type is "attr")
          expect(attrsTokens).to.be.empty

        if _.any(options.attrs, (attr) -> jadeSource.contains(attr))
          it "results should contain attr tokens if option.attrs contains valid values", ->
            translatableTokens = getTranslatableTokens(jadeSource, options)
            attrsTokens = _.filter(translatableTokens, (token) -> token.type is "attr")
            expect(attrsTokens).to.not.be.empty

        it "correct for line number shifts due to multiline tag + attrs declarations", ->
          for token in tokens
            str = if token.type is "attr" then token.name else token.val
            expect(lines[token.line]).to.contain str

      describe "(un)internationalize", ->
        it "internationalize result of the original source and internationalize result of the internationalized source shoud be the same", ->
          expect(i18nResult).to.deep.equal i18nResult2

        it "internationalized source with or without the tokens options should be the same", ->
          expect(i18nResult.source).to.equal internationalize(jadeSource, _.omit(options, 'tokens'))

        it "internationalized result tokens should match the strings json", ->
          actual = _.chain(i18nResult.tokens).pluck('val').sort().value()
          actual2 = _.chain(i18nResult2.tokens).pluck('val').sort().value()
          expect(actual).to.deep.equal stringsJson
          expect(actual2).to.deep.equal stringsJson

        it "internationalized tokens should have correct line numbers", ->
          resultLines = i18nResult.source.split("\n")
          for token in i18nResult.tokens
            {line, type, val} = token
            if isAlreadyWrapped(lines[line]) and type isnt "code"
              expect(lines[line]).to.contain escapeQuotes(val)
            else
              expect(lines[line]).to.contain val

            if type is "code"
              expect(resultLines[line]).to.contain unescapeQuotes(val)
            else
              expect(resultLines[line]).to.contain escapeQuotes(val)

        it "translation keys collected from an internationalized source and from an uninternationalized files should be identical", ->
          wrappedTranslationKeys = []
          for token in getTranslatableTokens(i18nResult.source, options)
            if token.type isnt "code" and isAlreadyWrapped(token.val)
              matches = wrappedString.exec(token.val)
              wrappedTranslationKeys.push unescapeQuotes(matches[2]) if matches?.length
            if token.type is "code"
              matches = extractAllMatches(token.val, wrappedStringInCode, 2)
              wrappedTranslationKeys = wrappedTranslationKeys.concat(matches)

          collectedTranslationKeys = _.pluck(i18nResult.tokens, "val")
          expect(collectedTranslationKeys).to.deep.equal wrappedTranslationKeys

        it "internationalize(original source) should equal to internationalized source", ->
          str = internationalize(jadeSource, options).source
          expect(str).to.equal i18nSource

        it "internationalize(internationalized source) should equal to internationalized source", ->
          str = internationalize(i18nSource, _.extend(options, i18nPath)).source
          expect(str).to.equal i18nSource

        it "uninternationalize(internationalized source) should equal to original source", ->
          str = uninternationalize(i18nSource, _.extend(options, i18nPath))
          expect(str).to.equal jadeSource

        it "uninternationalize(original source) should equal to original source", ->
          str = uninternationalize(jadeSource, options)
          expect(str).to.equal jadeSource

        it "uninternationalize(internationalize(str)) should equal str", ->
          str = uninternationalize(i18nResult.source, options)
          expect(str).to.equal jadeSource