function template(locals) {
var jade_debug = [{ lineno: 1, filename: "code.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "code.jade" });
jade_debug.unshift({ lineno: 1, filename: "code.jade" });
var str1 = _t('str1')
jade_debug.shift();
jade_debug.unshift({ lineno: 2, filename: "code.jade" });
var str2 = _t("str2")
jade_debug.shift();
jade_debug.unshift({ lineno: 3, filename: "code.jade" });
var str3 = str1 || _t('"str3"')
jade_debug.shift();
jade_debug.unshift({ lineno: 4, filename: "code.jade" });
var str4 = str2 && _t("'str4'")
jade_debug.shift();
jade_debug.unshift({ lineno: 5, filename: "code.jade" });
var strMap = {a: _t('a'), b: _t('b'), c: _t('c')}
jade_debug.shift();
jade_debug.unshift({ lineno: 6, filename: "code.jade" });
var strArr = [_t('Lorem ipsum dolor elit'), _t('Quo studio Aristophanem?'), _t("Magni enim leges, sed legibus partam")]
jade_debug.shift();
jade_debug.unshift({ lineno: 7, filename: "code.jade" });
var ignore = 'this should not be include'
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "- var str1 = _t('str1')\n- var str2 = _t(\"str2\")\n- var str3 = str1 || _t('\"str3\"')\n- var str4 = str2 && _t(\"'str4'\")\n- var strMap = {a: _t('a'), b: _t('b'), c: _t('c')}\n- var strArr = [_t('Lorem ipsum dolor elit'), _t('Quo studio Aristophanem?'), _t(\"Magni enim leges, sed legibus partam\")]\n- var ignore = 'this should not be include'\n");
}
}