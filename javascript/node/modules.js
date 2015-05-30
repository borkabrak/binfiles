var hello = require('./hello');
hello.speak();


// Let's explore how require handles both a <name>.js and a <name>/index.js..
// Answer:  Apparently it will use them in that order - top-level first, then
// index.js in a directory bearing the required name.
var smarmadon = require('./smarmadon');

smarmadon.speak();
