function template(locals) {
var jade_debug = [{ lineno: 1, filename: "complex.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (_t, annoying, course) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "complex.jade" });
jade_debug.unshift({ lineno: 1, filename: "complex.jade" });
buf.push("<span>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 2, filename: "complex.jade" });
buf.push("<strong>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 2, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("testing")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</strong>");
jade_debug.shift();
jade_debug.unshift({ lineno: 3, filename: "complex.jade" });
buf.push("" + (jade.escape((jade_interp = _t("really")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.unshift({ lineno: 4, filename: "complex.jade" });
buf.push("<strong>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 4, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("annoying")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</strong>");
jade_debug.shift();
jade_debug.unshift({ lineno: 5, filename: "complex.jade" });
buf.push("" + (jade.escape((jade_interp = _t("pipes")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.unshift({ lineno: 6, filename: "complex.jade" });
buf.push("<strong>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 6, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("with #{annoying}", {"annoying":annoying})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</strong>");
jade_debug.shift();
jade_debug.unshift({ lineno: 7, filename: "complex.jade" });
buf.push("" + (jade.escape((jade_interp = _t("interpolations annoying")) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.unshift({ lineno: 8, filename: "complex.jade" });
buf.push("<a" + (jade.attr("title", course.get('signatureTrackStatus')['signature_track_duration_left'], true, false)) + ">");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 8, filename: jade_debug[0].filename });
buf.push("" + (jade.escape((jade_interp = _t("#{course.get('signatureTrackStatus')['signature_track_duration_left']} left", {"course.get('signatureTrackStatus')['signature_track_duration_left']":course.get('signatureTrackStatus')['signature_track_duration_left']})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
buf.push("</a>");
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.shift();}.call(this,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined,"annoying" in locals_for_with?locals_for_with.annoying:typeof annoying!=="undefined"?annoying:undefined,"course" in locals_for_with?locals_for_with.course:typeof course!=="undefined"?course:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "span\n  strong testing\n  | really\n  strong annoying\n  | pipes\n  strong with #{annoying}\n  | interpolations annoying\n  a(title=course.get('signatureTrackStatus')['signature_track_duration_left']) #{course.get('signatureTrackStatus')['signature_track_duration_left']} left\n");
}
}