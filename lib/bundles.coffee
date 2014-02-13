_ = require("lodash")
glob = require("glob")
path = require("path")

util = require("./util")
sortObjectKeys = (o) -> _.pick(o, _.keys(o).sort()...)

toBundlePaths = (file) ->
  basename = path.basename(file, ".js.jade")
  dir = path.dirname(file)

  root:     "#{dir}/nls/#{basename}.js"
  english:  "#{dir}/nls/root/#{basename}.js"

exports.create = (file, i18nResult) ->
  return null if i18nResult?.tokens?.length is 0

  {root, english} = toBundlePaths(file)
  rootBundleContent = root: true
  stringDictionary = util.listToObj(_.pluck(i18nResult.tokens, "val"))

  [{
    type: "root"
    path: root
    content: rootBundleContent
  }, {
    type: "language"
    path: english
    content: stringDictionary
  }]

exports.remove = (file, i18nResult) ->
  {root} = toBundlePaths(file)
  nlsGlob = root.replace("nls/", "nls/**/")
  paths = glob.sync(globPath, cb)
  _.map(paths, (p) -> {path: p})
