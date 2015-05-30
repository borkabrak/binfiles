#!/usr/bin/env node
// My very own little baby test harness.  Isn't it adorable?
//
//		It will run the function you give it on each of the test cases you give
//		it.
//
//      TODO: Take an array of test functions instead of one, have the
//		test() function take the data..
//==============================================================================
exports.test = function(data){
	// data:
	//		data: Array of test cases
	//		func: function to run on each case
	var my = this;

	my.func = data.func;
	my.cases = data.cases;

	my.test = function(){
		for (var i = 0; i < my.cases.length; i++){
			my.func(my.cases[i]);
		}
	};
};

