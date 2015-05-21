function template(locals) {
var jade_debug = [{ lineno: 1, filename: "test/jade/header.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "test/jade/header.jade" });
jade_debug.unshift({ lineno: 1, filename: "test/jade/header.jade" });
buf.push("\n<header>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 2, filename: "test/jade/header.jade" });
buf.push("\n  <title>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 3, filename: "test/jade/header.jade" });
buf.push("" + (jade.escape((jade_interp = _t("this is a title")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</title>");
jade_debug.shift();
jade_debug.shift();
buf.push("\n</header>");
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "header\n  title\n    | #{_t(\"this is a title\")}");
}
}