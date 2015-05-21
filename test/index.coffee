fs = require 'fs'
path = require 'path'
jade = require 'jade'
{expect, assert} = require 'chai'
options = require './options'
transform = require '../lib/transform'

readFile = (p) -> fs.readFileSync(p, 'utf8')
String::contains = (str) -> @indexOf(str) >= 0

writeFile = (p, content) -> fs.writeFileSync(p, content, 'utf8')
withExt = (p, newExt) -> p.replace(path.extname(p), newExt)

rootPath = path.resolve(__dirname, '..')
casesPath = "#{__dirname}/jade"
ext = '.jade'
cases = fs.readdirSync(casesPath)
  .filter((f) -> f.contains(ext) and not f.contains('transformed'))
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

      before ->
        @jadeSource = readFile(filename)
        @jsSource = readFile(jsPath)
        @json = JSON.parse(readFile(jsonPath))
        filename = path.relative(rootPath, filename)

        @compiledJs = jade.compileClient @jadeSource, options({
          filename,
          postCompile: (compiler) => @strings = compiler.strings
        })

        result = transform(@jadeSource, {
          filename,
          attrs: [
            'data-default-message'
            'data-inflight-message'
            'data-success-message'
            'data-form-error'
            'data-form-correct'
            'data-tooltip'
            'placeholder'
          ]
        })
        @compiledTransforemdJs = jade.compileClient result.source, {
          filename
          compileDebug: true
          pretty: true
        }

        @transformedSource = result.source
        @transformedStrings = result.strings
        writeFile(withExt(filename, '.transformed.jade'), result.source)
        writeFile(withExt(filename, '.js'), @compiledTransforemdJs)

      it 'injects _t correctly during compilation', ->
        lineByLineDiff @compiledJs, @jsSource

      it 'extracts strings correctly', ->
        assert.deepEqual @strings, @json, "strings doesn't match content in #{jsonPath}"
        assert.deepEqual @transformedStrings, @json, "transformed strings doesn't match content in #{jsonPath}"
