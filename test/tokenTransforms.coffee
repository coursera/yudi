_ = require("lodash")
fs = require("fs")
{expect} = require("chai")

tokenTransforms = require("../lib/tokenTransforms")

describe "tokenTransforms", ->
  test = (type, testMap) ->
    describe type, ->
      it "should internationalize #{type} properly", ->
        for attribute, internationalized of testMap
          expect(tokenTransforms[type].internationalize(attribute)).to.equal internationalized

      it "should uninternationalize #{type} properly", ->
        for attribute, internationalized of testMap
          expect(tokenTransforms[type].uninternationalize(internationalized)).to.equal attribute

      it "uninternationalize(internationalize(str)) should equal str", ->
        for str in _.keys(testMap)
          expect(tokenTransforms[type].uninternationalize(tokenTransforms[type].internationalize(str))).to.equal str

  test "attr", {
    '': ''
    '""': '""'
    '"aoeu"': '_t("aoeu")'
    "'longer string'": "_t('longer string')"
    'disabled': 'disabled'
    'object.value()': 'object.value()'
    'something ? slightly.more("") : complicated': 'something ? slightly.more("") : complicated'
  }

  test "text", {
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
    'str with #{interpolation.get("a")}': '#{_t("str with #{interpolation.get(\\"a\\")}", {"interpolation.get(\\"a\\")":interpolation.get("a")})}'
    'str with <html>': '!{_t("str with <html>")}'
  }

  test "code", {
    '': ''
    '""': '_t("")'
    'aoeu': '_t(aoeu)'
    'object.value()': '_t(object.value())'
    'something ? slightly.more("") : complicated': '_t(something ? slightly.more("") : complicated)'
  }
