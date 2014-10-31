function template(locals) {
var jade_debug = [{ lineno: 1, filename: "mixins.jade" }];
try {
var buf = [];
var jade_mixins = {};
var jade_interp;

var jade_indent = [];
jade_debug.unshift({ lineno: 0, filename: "mixins.jade" });
jade_debug.unshift({ lineno: 1, filename: "mixins.jade" });























jade_debug.shift();
jade_debug.unshift({ lineno: 6, filename: "mixins.jade" });
jade_debug.shift();
jade_debug.unshift({ lineno: 7, filename: "mixins.jade" });

















































jade_debug.shift();
jade_debug.shift();;return buf.join("");
} catch (err) {
  jade.rethrow(err, jade_debug[0].filename, jade_debug[0].lineno, "mixin university-link(university, classes)\n  a.university-link(href=university.getLink(), class=classes)\n    if block\n      block\n\n//- some comment\nmixin c-time-commitment(momentObj, classes)\n  - var seconds = momentObj.seconds();\n  - var minutes = momentObj.minutes() + Math.round(seconds/60);\n  - var hours = momentObj.hours();\n  span(class=classes)\n    if hours\n      - minutes = ('0' + minutes.toString()).slice(-2);\n      | #{hours}h #{minutes}m\n    else if minutes\n      | #{minutes} min\n    else if seconds !== 0\n      | #{seconds} sec\n");
}
}