fs = require("fs")
path = require("path")
_ = require("lodash")

sourceTransforms = require("./sourceTransforms")
bundles = require("./bundles")

internationalize = (path, content, options) ->
  result = sourceTransforms.internationalize(content, options)
  _.extend result, bundles: bundles.create(path, result, options)

uninternationalize = (path, content, options) ->
  result = sourceTransforms.uninternationalize(content, options)
  _.extend result, bundles: bundles.remove(path, result, options)

module.exports = {internationalize, uninternationalize}