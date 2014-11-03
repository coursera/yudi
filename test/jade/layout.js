function template(locals) {
var jade_debug = [{ lineno: 1, filename: "test/jade/layout.jade" }];
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
buf.push("" + (jade.escape((jade_interp = _t("this is a layout")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</h1>");
jade_debug.shift();
jade_debug.unshift({ lineno: 3, filename: "test/jade/layout.jade" });
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
buf.push("");
jade_debug.shift();
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "h1 this is a layout\n\nblock content");
}
}