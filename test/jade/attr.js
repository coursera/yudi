function template(locals) {
var jade_debug = [{ lineno: 1, filename: "attr.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t, link) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "attr.jade" });
jade_debug.unshift({ lineno: 1, filename: "attr.jade" });
buf.push("\n<button" + (jade.attr("data-default-message", _t("Change Password"), true, false)) + (jade.attr("data-inflight-message", _t("Changing..."), true, false)) + (jade.attr("data-success-message", _t("Changed!"), true, false)) + " disabled=\"disabled\" class=\"btn\">");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 1, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("Change Password")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</button>");
jade_debug.shift();
jade_debug.unshift({ lineno: 3, filename: "attr.jade" });
buf.push("\n<div" + (jade.attr("data-default-message", _t("Change Password"), true, false)) + (jade.attr("data-inflight-message", _t("Changing..."), true, false)) + (jade.attr("data-success-message", _t("Changed!"), true, false)) + " disabled=\"disabled\" class=\"btn\">");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 7, filename: "attr.jade" });
buf.push("" + (jade.escape((jade_interp = _t("Change Password")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</div>");
jade_debug.shift();
jade_debug.unshift({ lineno: 9, filename: "attr.jade" });
buf.push("\n<attrtest" + (jade.attr("data-default-message", _t("this should be wrapped and recorded 1"), true, false)) + (jade.attr("data-inflight-message", _t("this should be wrapped and recorded 2"), true, false)) + (jade.attr("data-success-message", _t("this should be wrapped and recorded 3"), true, false)) + (jade.attr("data-form-error", _t('this should be wrapped and recorded 4'), true, false)) + (jade.attr("data-form-correct", _t('this should be wrapped and recorded 5'), true, false)) + (jade.attr("data-tooltip", _t('this should be wrapped and recorded 6'), true, false)) + (jade.attr("placeholder", _t('this should be wrapped and recorded 7'), true, false)) + " title=\"this should not be wrapped\" type=\"this should not be wrapped\" name=\"this should not be wrapped\" id=\"this should not be wrapped\" style=\"this should not be wrapped\" class=\"this should not be wrapped\">");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.shift();
buf.push("</attrtest>");
jade_debug.shift();
jade_debug.unshift({ lineno: 24, filename: "attr.jade" });
buf.push("\n<input type=\"text\" title=\"Your Email Address\" id=\"reset-email\"" + (jade.attr("placeholder", _t("Your Email Address"), true, false)) + "/>");
jade_debug.shift();
jade_debug.unshift({ lineno: 29, filename: "attr.jade" });
buf.push("\n<input type=\"text\" title=\"Your Email Address\" id=\"reset-email\"" + (jade.attr("placeholder", _t("Your Email Address"), true, false)) + " class=\"coursera-reset-input\"/>");
jade_debug.shift();
jade_debug.unshift({ lineno: 30, filename: "attr.jade" });
buf.push("<a" + (jade.attr("placeholder", _t("some " + (link) + ". this should be ignored"), true, false)) + ">");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 31, filename: "attr.jade" });
buf.push("<strong>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 31, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("testing")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</strong>");
jade_debug.shift();
jade_debug.unshift({ lineno: 32, filename: "attr.jade" });
buf.push("" + (jade.escape((jade_interp = _t("pipes")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</a>");
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined,"link" in locals_for_with?locals_for_with.link:typeof link!=="undefined"?link:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "button.btn(data-default-message=\"Change Password\", data-inflight-message=\"Changing...\", data-success-message=\"Changed!\", disabled) Change Password\n\ndiv.btn(\n  data-default-message=\"Change Password\",\n  data-inflight-message=\"Changing...\",\n  data-success-message=\"Changed!\", disabled)\n  | Change Password\n\nattrtest(\n  data-default-message=\"this should be wrapped and recorded 1\"\n  data-inflight-message=\"this should be wrapped and recorded 2\"\n  data-success-message=\"this should be wrapped and recorded 3\"\n  data-form-error='this should be wrapped and recorded 4'\n  data-form-correct='this should be wrapped and recorded 5'\n  data-tooltip='this should be wrapped and recorded 6'\n  placeholder='this should be wrapped and recorded 7'\n  title=\"this should not be wrapped\"\n  type=\"this should not be wrapped\"\n  name=\"this should not be wrapped\"\n  id=\"this should not be wrapped\"\n  class=\"this should not be wrapped\"\n  style=\"this should not be wrapped\"\n  )\ninput(\n  type=\"text\",\n  title=\"Your Email Address\",\n  id=\"reset-email\",\n  placeholder=\"Your Email Address\")\ninput.coursera-reset-input(type=\"text\", title=\"Your Email Address\", id=\"reset-email\", placeholder=\"Your Email Address\")\na(placeholder=\"some #{link}. this should be ignored\")\n  strong testing\n  | pipes\n");
}
}