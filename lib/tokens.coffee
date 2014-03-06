fs = require "fs"
_ = require "lodash"
{Parser, nodes} = require("jade")
{Text, Code, Comment} = nodes

indexOf = (lines, pattern, start) ->
  for line, i in lines[start..]
    return start + i if line.indexOf(pattern) >= 0
  return -1

extractAttrs = (node, attrs = []) ->
  _.chain(node.attrs)
  .filter((attr) -> _.contains(attrs, attr.name))
  .map(({name, val}) -> {type: "attr", line: node.line, name, val})
  .value()

isInclude = (node, filename) ->
  if 'filename' of node
    node.filename isnt filename
  else
    false

traverse = (node, tokens, filename, options) ->
  return [] if isInclude(node, filename)
  attrs = extractAttrs(node, options.attrs)

  children = node.nodes or node.block?.nodes
  childrenTokens = _.reduce(children, (memo, childNode) ->
    memo.concat(traverse(childNode, memo, filename, options))
  , [])

  if node.val and not (node instanceof Comment)
    if node instanceof Text
      type = "text"
    else if node instanceof Code
      type = "code"
    token = {val: node.val, line:node.line, type: type} if type

  _.compact(_.union(tokens, attrs, childrenTokens, [token]))

module.exports = (source, filename, options = {}) ->
  lines = source.split("\n")
  parser = new Parser(source, filename, options)
  ast = parser.parse()
  tokens = traverse(ast, [], filename, options)

  # correct text attr line numbers since multilined attributes will all
  # correspond to the same line due to the Lexer
  for node in tokens
    # jade linenumbers are 1 based
    node.line -= 1
    if node.type is "attr"
      line = lines[node.line]
      if line.indexOf(node.name) < 0
        node.line = indexOf(lines, node.name, node.line)

  _.sortBy(tokens, "line")
