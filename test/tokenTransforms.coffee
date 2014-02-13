_ = require("lodash")
fs = require("fs")
{expect} = require("chai")

{attr, text} = require("../lib/tokenTransforms")

describe "tokenTransforms", ->
  describe "attr", ->
    before ->
      @attrs =
        '': ''
        '""': '""'
        '"aoeu"': '_t("aoeu")'
        '"longer string"': '_t("longer string")'
        'disabled': 'disabled'
        'object.value()': 'object.value()'
        'something ? slightly.more("") : complicated': 'something ? slightly.more("") : complicated'

    it "should internationalize attr properly", ->
      for attribute, internationalized of @attrs
        expect(attr.internationalize(attribute)).to.equal internationalized

    it "should uninternationalize attr properly", ->
      for attribute, internationalized of @attrs
        expect(attr.uninternationalize(internationalized)).to.equal attribute

    it "uninternationalize(internationalize(str)) should equal str", ->
      for str in _.keys(@attrs)
        expect(attr.uninternationalize(attr.internationalize(str))).to.equal str

  describe "text", ->
    before ->
      @texts =
        '': ''
        '""': '""'
        'aoeu': '#{_t("aoeu")}'
        'longer string !': '#{_t("longer string !")}'
        '"longer string with quotes"': '#{_t("\\"longer string with quotes\\"")}'
        "'longer string with single quotes'": '#{_t("\'longer string with single quotes\'")}'
        '#{var}': '#{_t(var)}'
        '#{complicated.expression("")}': '#{_t(complicated.expression(""))}'
        '!!': '!!'
        '&nbsp;': '&nbsp;'
        '123': '123'
        'str with #{interpolation}': '#{_t("str with #{interpolation}", {"interpolation":interpolation})}'
        'str with <html>': '!{_t("str with <html>")}'

    it "should internationalize text properly", ->
      for t, internationalized of @texts
        expect(text.internationalize(t)).to.equal internationalized

    it "should uninternationalize text properly", ->
      for t, internationalized of @texts
        expect(text.uninternationalize(internationalized)).to.equal t

    it "uninternationalize(internationalize(str)) should equal str", ->
      for str in _.keys(@texts)
        expect(text.uninternationalize(text.internationalize(str))).to.equal str

