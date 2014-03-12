fs = require "fs"
_ = require "lodash"
{Parser, nodes, runtime} = require("jade")
{Text, Code, Comment, BlockComment} = nodes

indexOf = (lines, pattern, start) ->
  for line, i in lines[start..]
    return start + i if line.indexOf(pattern) >= 0
  return -1

containsInterpolation = (s) ->
  _.isString(s) and (s.indexOf(') + "') >= 0 or s.indexOf('" + (') >= 0)

extractAttrs = (node, attrs = []) ->
  _.chain(node.attrs)
    .filter (attr) ->
      _.contains(attrs, attr.name) && !containsInterpolation(attr.val)
    .map ({name, val}) -> {type: "attr", line: node.line, name, val}
    .value()

isInclude = (node, options) ->
  if 'filename' of node
    node.filename isnt options.filename
  else
    false

traverse = (node, tokens, options) ->
  if isInclude(node, options) or
      node instanceof Comment or
      node instanceof BlockComment
    return []

  attrs = extractAttrs(node, options.attrs)

  children = node.nodes or node.block?.nodes
  childrenTokens = _.reduce(children, (memo, childNode) ->
    memo.concat(traverse(childNode, memo, options))
  , [])

  if node.val
    if node instanceof Text
      type = "text"
    else if node instanceof Code
      type = "code"
    token = {val: node.val, line:node.line, type: type} if type

  _.compact(_.union(tokens, attrs, childrenTokens, [token]))

module.exports = (source, options = {}) ->
  lines = source.split("\n")
  parser = new Parser(source, options.filename, options)

  try
    ast = parser.parse()
    tokens = traverse(ast, [], options)
  catch e
    parser = parser.context()
    runtime.rethrow(e, parser.filename, parser.lexer.lineno, parser.input)

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
