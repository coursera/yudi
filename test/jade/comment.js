function template(locals) {
var jade_debug = [{ lineno: 1, filename: "test/jade/comment.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "test/jade/comment.jade" });
jade_debug.unshift({ lineno: 1, filename: "test/jade/comment.jade" });
buf.push("\n<!--");
jade_debug.unshift({ lineno: 1, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 1, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("p test html comment text")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("\n-->");
jade_debug.shift();
jade_debug.unshift({ lineno: 2, filename: "test/jade/comment.jade" });
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "//\n  p test html comment text\n//-\n  p test jade comment text");
}
}