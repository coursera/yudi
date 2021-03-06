function template(locals) {
var jade_debug = [{ lineno: 1, filename: "test/jade/simple.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t, complicated, interpolations, javascript, onlyVar, strings) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "test/jade/simple.jade" });
jade_debug.unshift({ lineno: 1, filename: "test/jade/simple.jade" });
buf.push("\n<div>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 2, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 2, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("simple string detection")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 3, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 3, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("strings with #{interpolations}", {"interpolations":_t(interpolations)})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 4, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 4, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("#{strings} with multiple #{interpolations}", {"strings":_t(strings), "interpolations":_t(interpolations)})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 5, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 5, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("strings with #{javascript.code()}", {"javascript.code()":_t(javascript.code())})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 6, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 6, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("strings with #{complicated + javascript.code(\"with quoted strings\")}", {"complicated + javascript.code(\"with quoted strings\")":_t(complicated + javascript.code("with quoted strings"))})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 7, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 7, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t(onlyVar)) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 8, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 8, filename: jade_debug[0].filename });
buf.push("123");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 9, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 9, filename: jade_debug[0].filename });
buf.push("!!!");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 10, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 10, filename: jade_debug[0].filename });
buf.push("$100");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 11, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 11, filename: jade_debug[0].filename });
buf.push("&nbsp;");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 12, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 12, filename: jade_debug[0].filename });
buf.push("" + (((jade_interp = _t("&nbsp; look! there's a trailing space")) == null ? '' : jade_interp)) + " ");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 13, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 13, filename: jade_debug[0].filename });
buf.push("" + (((jade_interp = _t("&nbsp; look! there's more space")) == null ? '' : jade_interp)) + "  ");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 14, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 14, filename: jade_debug[0].filename });
buf.push("" + (((jade_interp = _t("&nbsp; look! there's a trailing space&nbsp;")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 15, filename: "test/jade/simple.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 15, filename: jade_debug[0].filename });
buf.push("" + (((jade_interp = _t("&nbsp; look! there's more space&nbsp;&nbsp;")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.shift();
buf.push("</div>");
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined,"complicated" in locals_for_with?locals_for_with.complicated:typeof complicated!=="undefined"?complicated:undefined,"interpolations" in locals_for_with?locals_for_with.interpolations:typeof interpolations!=="undefined"?interpolations:undefined,"javascript" in locals_for_with?locals_for_with.javascript:typeof javascript!=="undefined"?javascript:undefined,"onlyVar" in locals_for_with?locals_for_with.onlyVar:typeof onlyVar!=="undefined"?onlyVar:undefined,"strings" in locals_for_with?locals_for_with.strings:typeof strings!=="undefined"?strings:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "div\n  span simple string detection\n  span strings with #{interpolations}\n  span #{strings} with multiple #{interpolations}\n  span strings with #{javascript.code()}\n  span strings with #{complicated + javascript.code(\"with quoted strings\")}\n  span #{onlyVar}\n  span 123\n  span !!!\n  span $100\n  span &nbsp;\n  span &nbsp; look! there's a trailing space \n  span &nbsp; look! there's more space  \n  span &nbsp; look! there's a trailing space&nbsp;\n  span &nbsp; look! there's more space&nbsp;&nbsp;\n");
}
}