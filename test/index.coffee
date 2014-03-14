_ = require("lodash")
fs = require("fs")
{expect} = require("chai")

getTranslatableTokens = require("../lib/tokens")
tokenTransforms = require("../lib/tokenTransforms")
{internationalize, uninternationalize} = require("../lib")
{isAlreadyWrapped} = require("../lib/regex")
{escapeQuotes, unescapeQuotes, extractAllMatches} = require("../lib/util")

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
    options = {
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
    }
    tokens = getTranslatableTokens(jadeSource, {filename})
    tokensWithAttrs = getTranslatableTokens(jadeSource, {filename, attrs: options.attrs})
    i18nResult = internationalize(jadeSource, options)
    i18nResult2 = internationalize(i18nResult.source, options)
    stringsJson = if i18nResult.tokens?.length then JSON.parse(readFile(stringsJsonPath)) else []

    describe "#{name}:", ->
      describe "getTranslatableTokens:", ->

        it "normalized tokens from the original source and any internationalized sources should be identical", ->
          normalizeTokens = (source, options) ->
            sourceTokens = getTranslatableTokens(source, options)
            for token in sourceTokens
              transformers = tokenTransforms[token.type]
              if transformers
                token.val = transformers.uninternationalize(token.val)
            sourceTokens
          expect(tokensWithAttrs).to.deep.equal normalizeTokens(i18nSource, options)
          expect(tokensWithAttrs).to.deep.equal normalizeTokens(i18nResult.source, options)
          expect(tokensWithAttrs).to.deep.equal normalizeTokens(i18nResult2.source, options)

        it "results should not contain attr tokens if attrs list is not passed in through options", ->
          attrsTokens = _.filter tokens, (token) ->
            token.type is "attr" and token.filename = filename
          expect(attrsTokens).to.be.empty

        it "results should not contain attr tokens if no attribute in option.attrs exists", ->
          attrs = ["this-should-not-be-an-attribute", "or-this"]
          attrsTokens = _.filter getTranslatableTokens(jadeSource, {filename, attrs}), (token) ->
            token.type is "attr" and token.filename = filename
          expect(attrsTokens).to.be.empty

        if _.any(options.attrs, (attr) -> jadeSource.contains(attr))
          it "results should contain attr tokens if option.attrs contains valid values", ->
            attrsTokens = _.filter(tokensWithAttrs, (token) -> token.type is "attr")
            expect(attrsTokens).to.not.be.empty

        it "correct for line number shifts due to multiline tag + attrs declarations", ->
          for token in tokens when token.filename is filename
            str = if token.type is "attr" then token.name else token.val
            expect(lines[token.line]).to.contain str

      describe "(un)internationalize:", ->
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
          for token in i18nResult.tokens when token.filename is filename
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
          i18nResultKeys = _.pluck(i18nResult.tokens, "val")
          i18nResult2Keys = _.pluck(i18nResult2.tokens, "val")
          expect(i18nResultKeys).to.deep.equal i18nResult2Keys

        it "internationalize(original source) should equal to internationalized source", ->
          str = internationalize(jadeSource, options).source
          expect(str).to.equal i18nSource

        it "internationalize(internationalized source) should equal to internationalized source", ->
          str = internationalize(i18nSource, _.extend(options, {filename:i18nPath})).source
          expect(str).to.equal i18nSource

        it "uninternationalize(internationalized source) should equal to original source", ->
          str = uninternationalize(i18nSource, _.extend(options, {filename:i18nPath}))
          expect(str).to.equal jadeSource

        it "uninternationalize(original source) should equal to original source", ->
          str = uninternationalize(jadeSource, options)
          expect(str).to.equal jadeSource

        it "uninternationalize(internationalize(str)) should equal str", ->
          str = uninternationalize(i18nResult.source, options)
          expect(str).to.equal jadeSource