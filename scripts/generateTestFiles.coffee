#!/usr/bin/env coffee

_ = require 'lodash'
fs = require 'fs'
path = require 'path'
jade = require 'jade'

options = require '../test/options'

filename = process.argv[2]

readFile = (p) -> fs.readFileSync(p, 'utf8')
writeFile = (p, content) -> fs.writeFileSync(p, content, 'utf8')
withExt = (p, newExt) -> p.replace(path.extname(p), newExt)

content = readFile(filename)
js = jade.compileClient content, options({
  filename: filename
  postCompile: (compiler) ->
    json = JSON.stringify(compiler.strings, null, '  ')
    writeFile(withExt(filename, '.json'), "#{json}\n")
})

writeFile(withExt(filename, '.js'), js)
