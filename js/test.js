#!/usr/bin/env node
require("./jclib.js");
var Test = require("./Test.js");

// Testing..
var objects = new Test({

	cases: [{
	one: 1,
	two: 2,
	three: 3,
	griffins: {
		father: "Peter",
		mother: "Lois",
		dog:    "Brian"
	},
	weekdays: [
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday"
	]
}],

	func: function(x){
		x.contains("dog");
	}

});

var isprime = new Test({
    cases: Math.seq(2,500),
    func: function(n){
        var s_res = Math.sieve_prime(n);
        var n_res = Math.is_prime(n);
        if ( s_res !== n_res ) {
            console.log("\tError: is_prime(%s) => %s, sieve_prime(%s) => %s ", n, n_res, n, s_res);
        };
    }
});

var sieve = new Test({
    cases: [10],
    func: function(n){
        console.log("Math.primes(%s): %s", n, Math.primes(n));
    }
});

var strings = new Test({
	cases:
		[
			"Jonathan",
			"radar",
            "10110",
            "0",
            "1",
            "10",
            "111",
		],
	func:
		function(x){
			console.log("'%s':",x);
			console.log("\tReverse: '%s'", x.reverse());
			console.log("\tIs%s a palindrome.: ", x.is_palindrome() ? "" : " NOT");
            //console.log("\tdecimal version: %s", x.to_decimal(2));
		}
});


require("./jclib.js");
console.log("Testing..");
console.log("STRINGS:");
strings.test();
//console.log("OBJECTS:");
//objects.test();
//console.log("MATH:");
//isprime.test();
