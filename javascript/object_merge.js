#!/usr/bin/env js

"use strict";

function object_merge(obj1, obj2) {
    var retval = {};

    // For each object in the argument list
    for (var i = 0; i < arguments.length; i++) {

        var current_object = arguments[i];
        // Add each property to the return val
        for(var property in current_object) {
            if (typeof retval[property] === "undefined") {
                retval[property] = current_object[property];
            }
        }
    }
    return retval;
}

var obj1 = {
    one: "uno",
    two: "dos"
};

var obj2 = {
    three: "tres",
    four: "quatro"
};

function is_equal(x,y) {
    console.log("equal(", x, ",", y, ")");
    var retval = (x == y);
    console.log("retval", retval);
    return retval;
}

var tests = [

    {
    description: "Merge two depth one objects",
    assertion: function() {
        return is_equal(
            object_merge({ a: 1, b: 2 }, {c: 3, d: 4}),
            { a: 1, b: 2, c: 3, d: 4})} },

];

tests.forEach(function(test) {
    console.log(test.description, ":");
    console.log(test.assertion.call(this) ? "passed" : "FAIL");
});

console.log("object 1:", obj1);
console.log("object 2:", obj2);
console.log("object_merge(obj1, obj2): ", object_merge(obj1, obj2));
