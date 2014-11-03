fs = require 'fs'
path = require 'path'
jade = require 'jade'
{expect, assert} = require 'chai'
options = require './options'

readFile = (p) -> fs.readFileSync(p, 'utf8')
String::contains = (str) -> @indexOf(str) >= 0

rootPath = path.resolve(__dirname, '..')
casesPath = "#{__dirname}/jade"
ext = '.jade'
cases = fs.readdirSync(casesPath)
  .filter((f) -> f.contains(ext))
  .map((f) -> f.replace(ext, ""))

lineByLineDiff = (actual, expected) ->
  actualLines = actual.split('\n')
  expectedLines = expected.split('\n')
  for line, i in actualLines when i > 1
    assert.equal actualLines[i], expectedLines[i], "line #{i} are not the same"

describe 'cases', ->
  cases.forEach (test) ->
    name = test.replace(/[-.]/g, " ")

    filename = "#{casesPath}/#{test}#{ext}"
    jsPath = "#{casesPath}/#{test}.js"
    jsonPath = "#{casesPath}/#{test}.json"

    describe "#{name}:", ->

      beforeEach ->
        @jadeSource = readFile(filename)
        @jsSource = readFile(jsPath)
        @json = JSON.parse(readFile(jsonPath))

        @compiledJs = jade.compileClient @jadeSource, options({
          filename: path.relative(rootPath, filename)
          postCompile: (compiler) => @strings = compiler.strings
        })

      it 'injects _t correctly during compilation', ->
        lineByLineDiff @compiledJs, @jsSource

      it 'extracts strings correctly', ->
        assert.deepEqual @strings, @json, "strings doesn't match content in #{jsonPath}"
