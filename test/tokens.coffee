_ = require("lodash")
fs = require("fs")
{expect} = require("chai")

getTranslatableTokens = require("../lib/tokens")

filename = "#{__dirname}/jade/test.jade"

describe "tokens", ->
  before (done) ->
    fs.readFile filename, "utf-8", (e, d) =>
      @jadeSource = d
      @lines = (@jadeSource ? "").split("\n")
      @tokens = getTranslatableTokens(@jadeSource, {filename})
      done(e)

  describe "getTranslatableTokens", ->

    it "results should not contain attr tokens if attrs list is not passed in through options", ->
      attrsTokens = _.filter(@tokens, (token) -> token.type is "attr")
      expect(attrsTokens).to.be.empty

    it "results should not contain attr tokens if no attribute in option.attrs exists", ->
      attrs = ["this-should-not-be-an-attribute", "or-this"]
      attrsTokens = _.filter(getTranslatableTokens(@jadeSource, {filename, attrs}), (token) -> token.type is "attr")
      expect(attrsTokens).to.be.empty

    it "results should contain attr tokens if option.attrs contains valid values", ->
      attrs = ["data-inflight-message", "placeholder"]
      translatableTokens = getTranslatableTokens(@jadeSource, {filename, attrs})
      attrsTokens = _.filter(translatableTokens, (token) -> token.type is "attr")
      expect(attrsTokens).to.not.be.empty

    it "correct for line number shifts due to multiline tag + attrs declarations", ->
      for token in @tokens
        str = if token.type is "attr" then token.name else token.val
        expect(@lines[token.line]).to.contain str
