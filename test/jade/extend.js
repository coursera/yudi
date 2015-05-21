function template(locals) {
var jade_debug = [{ lineno: 1, filename: "test/jade/extend.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "test/jade/layout.jade" });
jade_debug.unshift({ lineno: 1, filename: "test/jade/layout.jade" });
buf.push("\n<h1>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 1, filename: jade_debug[0].filename });
buf.push("this is a layout");
jade_debug.shift();
jade_debug.shift();
buf.push("</h1>");
jade_debug.shift();
jade_debug.unshift({ lineno: 3, filename: "test/jade/extend.jade" });
jade_debug.unshift({ lineno: 3, filename: "test/jade/extend.jade" });
buf.push("\n<p>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 4, filename: "test/jade/extend.jade" });
buf.push("" + (jade.escape((jade_interp = _t("this is the blocks content")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</p>");
jade_debug.shift();
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "extends layout\nblock content\n  p\n    | #{_t(\"this is the blocks content\")}");
}
}