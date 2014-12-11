function template(locals) {
var jade_debug = [{ lineno: 1, filename: "test/jade/interpolation.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t, test, test2, test3, test4) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "test/jade/interpolation.jade" });
jade_debug.unshift({ lineno: 1, filename: "test/jade/interpolation.jade" });
buf.push("\n<p>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 1, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t(test)) == null ? '' : jade_interp)) + " 1");
jade_debug.shift();
jade_debug.shift();
buf.push("</p>");
jade_debug.shift();
jade_debug.unshift({ lineno: 2, filename: "test/jade/interpolation.jade" });
buf.push("\n<p>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 2, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("#{test2} + #{test3}", {"test2":_t(test2), "test3":_t(test3)})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</p>");
jade_debug.shift();
jade_debug.unshift({ lineno: 3, filename: "test/jade/interpolation.jade" });
buf.push("\n<p>" + (jade.escape(null == (jade_interp = _t(test4)) ? "" : jade_interp)));
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.shift();
buf.push("</p>");
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined,"test" in locals_for_with?locals_for_with.test:typeof test!=="undefined"?test:undefined,"test2" in locals_for_with?locals_for_with.test2:typeof test2!=="undefined"?test2:undefined,"test3" in locals_for_with?locals_for_with.test3:typeof test3!=="undefined"?test3:undefined,"test4" in locals_for_with?locals_for_with.test4:typeof test4!=="undefined"?test4:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "p #{test} 1\np #{test2} + #{test3}\np= test4\n");
}
}
