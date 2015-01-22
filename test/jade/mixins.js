function template(locals) {
var jade_debug = [{ lineno: 1, filename: "test/jade/mixins.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (Math, _t) {
var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "test/jade/mixins.jade" });
jade_debug.unshift({ lineno: 1, filename: "test/jade/mixins.jade" });
jade_mixins["university-link"] = function(university, classes){
var block = (this && this.block), attributes = (this && this.attributes) || {};
jade_debug.unshift({ lineno: 2, filename: "test/jade/mixins.jade" });
jade_debug.unshift({ lineno: 2, filename: "test/jade/mixins.jade" });
buf.push("<a" + (jade.attr("href", university.getLink(), true, false)) + (jade.cls(['university-link',classes], [null,true])) + ">");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 3, filename: "test/jade/mixins.jade" });
if ( block)
{
jade_debug.unshift({ lineno: 4, filename: "test/jade/mixins.jade" });
jade_debug.unshift({ lineno: undefined, filename: "test/jade/mixins.jade" });
jade_indent.push('  ');
block && block();
jade_indent.pop();
jade_debug.shift();
jade_debug.shift();
}
jade_debug.shift();
jade_debug.shift();
buf.push("</a>");
jade_debug.shift();
jade_debug.shift();
};
jade_debug.shift();
jade_debug.unshift({ lineno: 6, filename: "test/jade/mixins.jade" });
jade_debug.shift();
jade_debug.unshift({ lineno: 7, filename: "test/jade/mixins.jade" });
jade_mixins["c-time-commitment"] = function(momentObj, classes, endString){
var block = (this && this.block), attributes = (this && this.attributes) || {};
jade_debug.unshift({ lineno: 8, filename: "test/jade/mixins.jade" });
jade_debug.unshift({ lineno: 8, filename: "test/jade/mixins.jade" });
var seconds = momentObj.seconds();
jade_debug.shift();
jade_debug.unshift({ lineno: 9, filename: "test/jade/mixins.jade" });
var minutes = momentObj.minutes() + Math.round(seconds/60);
jade_debug.shift();
jade_debug.unshift({ lineno: 10, filename: "test/jade/mixins.jade" });
var hours = momentObj.hours();
jade_debug.shift();
jade_debug.unshift({ lineno: 11, filename: "test/jade/mixins.jade" });
buf.push("<span" + (jade.cls([classes], [true])) + ">");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 12, filename: "test/jade/mixins.jade" });
if ( hours)
{
jade_debug.unshift({ lineno: 13, filename: "test/jade/mixins.jade" });
jade_debug.unshift({ lineno: 13, filename: "test/jade/mixins.jade" });
minutes = ('0' + minutes.toString()).slice(-2);
jade_debug.shift();
jade_debug.unshift({ lineno: 14, filename: "test/jade/mixins.jade" });
buf.push("" + (jade.escape((jade_interp = _t("#{hours}h #{minutes}m", {"hours":_t(hours), "minutes":_t(minutes)})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
}
else if ( minutes)
{
jade_debug.unshift({ lineno: 16, filename: "test/jade/mixins.jade" });
jade_debug.unshift({ lineno: 16, filename: "test/jade/mixins.jade" });
buf.push("" + (jade.escape((jade_interp = _t("#{minutes} min", {"minutes":_t(minutes)})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
}
else if ( seconds !== 0)
{
jade_debug.unshift({ lineno: 18, filename: "test/jade/mixins.jade" });
jade_debug.unshift({ lineno: 18, filename: "test/jade/mixins.jade" });
buf.push("" + (jade.escape((jade_interp = _t("#{seconds} sec", {"seconds":_t(seconds)})) == null ? '' : jade_interp)) + "");
jade_debug.shift();
jade_debug.shift();
}
jade_debug.shift();
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.unshift({ lineno: 19, filename: "test/jade/mixins.jade" });
buf.push("<span>" + (jade.escape(null == (jade_interp = _t(endString)) ? "" : jade_interp)));
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.shift();
buf.push("</span>");
jade_debug.shift();
jade_debug.shift();
};
jade_debug.shift();
jade_debug.unshift({ lineno: 21, filename: "test/jade/mixins.jade" });
jade_indent.push('');
jade_mixins["c-time-commitment"]({}, '', _t('some string'));
jade_indent.pop();
jade_debug.shift();
jade_debug.unshift({ lineno: 22, filename: "test/jade/mixins.jade" });
jade_indent.push('');
jade_mixins["university-link"].call({
block: function(){
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 23, filename: "test/jade/mixins.jade" });
buf.push("\n");
buf.push.apply(buf, jade_indent);
buf.push("<div>");
jade_debug.unshift({ lineno: undefined, filename: jade_debug[0].filename });
jade_debug.unshift({ lineno: 23, filename: jade_debug[0].filename });
buf.push("1");
jade_debug.shift();
jade_debug.shift();
buf.push("</div>");
jade_debug.shift();
jade_debug.shift();
}
}, {}, _t('some string with block'));
jade_indent.pop();
jade_debug.shift();
jade_debug.shift();}.call(this,"Math" in locals_for_with?locals_for_with.Math:typeof Math!=="undefined"?Math:undefined,"_t" in locals_for_with?locals_for_with._t:typeof _t!=="undefined"?_t:undefined));;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "mixin university-link(university, classes)\n  a.university-link(href=university.getLink(), class=classes)\n    if block\n      block\n\n//- some comment\nmixin c-time-commitment(momentObj, classes, endString)\n  - var seconds = momentObj.seconds();\n  - var minutes = momentObj.minutes() + Math.round(seconds/60);\n  - var hours = momentObj.hours();\n  span(class=classes)\n    if hours\n      - minutes = ('0' + minutes.toString()).slice(-2);\n      | #{hours}h #{minutes}m\n    else if minutes\n      | #{minutes} min\n    else if seconds !== 0\n      | #{seconds} sec\n  span= endString\n\n+c-time-commitment({}, '', _t('some string'))\n+university-link({}, _t('some string with block'))\n  div 1\n");
}
}