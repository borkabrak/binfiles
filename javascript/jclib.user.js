/* 
    Personal javascript library.
    ==============================================================================

    This file contains extensions to the javascript object hierarchy.  This is
    the copy I use to work, and SHOULD NOT be left in an unstable state.
*/

// String
//==============================================================================
String.prototype.reverse = function(){
    //Another way to reverse a string is to use Array's reverse:
    //  `this.split('').reverse().join('')`; 
    //but that's boring, and recursion is fun!
	if (this.length < 2) { return this.toString() };
	return this.slice(-1) + this.slice(0,-1).reverse();
}

String.prototype.is_palindrome = function(){
	return this.toString() === this.reverse();
}

String.prototype.to_decimal = function(radix){
    var length = this.length;
    var first_digit = this.slice(0,1);
    var other_digits = this.slice(1);

    if (length < 1) return 0;
    return (first_digit * Math.pow(radix,length-1)) + other_digits.to_decimal(radix);
};

String.prototype.pad = function(len, character, left){
    /*
        Pad a string:

            * to length len
            * with character
            * on the left instead of right?
    */

    len = len || 0;
    character = character || ' ';
    return (this.length >= len) ? 
        this.toString() : 
        (left? character + this : this + character).pad(len, character, left);
}

String.prototype.capitalize = function(){
    /* Uppercase the first character */
    return this[0].toUpperCase() + this.slice(1);
}

// Object
//==============================================================================
Object.dc_create = function(o) {
    /*
        True prototypal inheritance, instead of pseudo-classical inheritance.
        Objects inherit directly from other objects, instead of having classes
        to act as intermediaries.

            newObject = Object.create(oldObject);

        Gleaned from Douglas Crockford's (hence the name) recommendation at:
            
            http://javascript.crockford.com/prototypal.html


        Browser vendors have subsequently implemented an Object.create.
        Contrast and compare at:

            https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Object/create

    */

    function F() {}
    F.prototype = o;
    return new F();
}

Object.prototype.walk = function(func){
    // recursively walk every node in the object, calling a function on each
    // property.

	for(i in this){

        if (this.hasOwnProperty(i)){

            if (typeof this[i] === "object"){
                this[i].walk(func);
            } else {
                func(i,this);
            };

        };

	};

};

Object.prototype.contains = function(target_property){
    /* 
     * Return whether this object contains the given property, at any point in
     * its hierarchy.
     */

	var my = this;
    var retval = false;
	this.walk(function(current_property,obj){
		if (current_property === target_property){
            retval = true;
		}
	});
    return retval;
};

Object.prototype.forEach = function(f){
    /*
     * Call a function on each property of an Object.
     *
     * The function is passed each property's name and value.
     */

    for (var i in this) {
        if (this.hasOwnProperty(i)) {
            f.call(this, i, this[i]);
        }
    }
}

Object.prototype.ownProps = function(){
    /*
     * List an object's own properties, and their values.
     * 
     * This is for development, and requires the `console` object.
     *
     * Hrm.. this apparently is redundant.  Compare to Object.prototype.forEach, and try:
     *      obj.forEach( function(k,v){ console.log("%s: %o", k, v) } );
     */
    for (var i in this) { 
        if (this.hasOwnProperty(i)) { 
            console.log("%s: %o", i, this[i]) 
        } 
    }
}

// Math
//==============================================================================
// (We don't hang things on Math.prototype; it's not a constructor)

Math.seq = function(x, y, step){
    // Return an array of integers in a particular sequence
    //
    //      * Two parameters represent start and endpoints (non-inclusive) 
    //              (4,10)      => [4,5,6,7,8,9]
    //
    //      * One parameter, x, returns 0..x
    //              (10)        => [0,1,2,3,4,5,6,7,8,9]
    //
    //      * 'step' is the difference between each element (default: 1)
    //              (4,10,2)    => [4,6,8]
    //
    //      * If the second parameter is less than the first, return a
    //      descending sequence
    //              (10,4)      => [10,9,8,7,6,5]
    //
    //      * You can give a negative step, but its absolute value is all that
    //      matters.  This prevents confusion (and endless loops), i.e., when
    //      counting down, do we make step negative?  Doesn't matter!
    //              (10,4,-2)   => [10,8,6]  
    //              (10,4,2)    => [10,8,6]  
    //              (4,10,-2)   => [4,6,8]  This happens too, but do you care?
    //
    //      -jdc 11/2/2012

    var start = y ? x : 0;
    var end = y || x;
    step = (Math.abs(step) || 1) * ( (end > start) ? 1 : -1 );

    var range = [];
    for(var i = start; (end > start) ? (i < end) : (i > end); i += step){
        range.push(i); }

    return range;
};

Math.is_prime = function(x){
    // This is quite a straightforward algorithm, but it's inefficient
    for (var i=2;i <= Math.sqrt(x); i++){
        if (x % i === 0) return false;
    }
    return true;
};

Math.primes = function(x){
    // Return a list of all primes less than or equal to x.  This method is
    // called the Sieve of Eratosthenes.
    // This isn't a strictly accurate implementation, but it follows the general idea of
    // running through 1..x and, for every prime, taking out multiples of that prime as you go.
    //
    // Probably needs some cleanup, but I'll leave it for now.

    var list = Math.seq(2, x + 1);
    var newlist = [];
    var primes = [];
    var allprime = false;

    while (!allprime) {

        primes.push(list[0]);
        newlist = [];
        allprime = true;
        for(var i = 0; i < list.length; i++){
            if ( (list[i] % primes.slice(-1)) !== 0) {
                newlist.push(list[i]);
                allprime = false;
            };
        };

        list = newlist;
    };

    return primes;
};

Math.randomNumber = function(x, y){
    /* 
        Return a random integer in the range given [x-y], inclusive.

        This algorithm was found in a Stack Overflow question.  The accepted
        answer contains an interesting and thorough explanation of how it
        works.  Check it out at: 
        http://stackoverflow.com/questions/1527803/generating-random-numbers-in-javascript-in-a-specific-range
    */
    min = y ? x : 0;
    max = y || x;
    return Math.floor(Math.random() * (max - min + 1)) + min;
};

Number.prototype.times = function(f){
    /*
        Repeat a function a certain number of times.  Modeled after the similar
        construct in Ruby.  Each run, the function is passed the index of how
        many times it's been run (starting at zero).

        NOTE: Because the method reference notation interferes with Number
        decimal notation, parentheses must be used when calling this on a
        literal Number.
        
        For example,:
            
            10.times(function(n){ console.log("n:%s",n) };

        THAT DOES NOT WORK.  (The period is ambiguous to the parser -- maybe
        it's a decimal?).  Parentheses can be used to disambiguate:

            (10).times(function(n){ console.log("n:%s",n) }; // <== THIS WORKS!

        Or, alternatively, just use a variable:
            
            x = 10; 
            x.times(function(n){ console.log("n:%s",n) };

    */

    for (var i = 0; i < this; i++){
        f.call(this, i);
    }
}

Array.prototype.reorder = function(order){
    /* 
     Reorder the elements in the array, returning the new order as an array
     of indices.  
     
     order: Array of indices indicating the order in which to place the array.  Default is random.    

     Examples:  
    
          * ["zero", "one","two"].reorder() *may* (randomly) reorder the array as
              ["two","zero","one"] and in that case will return [2,0,1].
    
          * ["zero", "one", "two"].reorder([2,1,0]) *will* change the array to ["two", "one", "zero"].
    */

    if (!order) {
        // Generate a random order
        var order = [];
        var indices = Math.seq(this.length);
        while (indices.length){
            order.push(indices.splice(Math.randomNumber(0,indices.length - 1), 1)[0]);
        }
    };

    // Make an array with our elements in a new order
    var newArr = this.map( 

        function(x,y){ 
            return this[order[y]]; }, 

        this 

    );

    // Replace our elements with the new order (Viva la revolucion!)
    newArr.forEach( 

        function(x,y){ 
            this[y] = x; }, 

        this

    );

    return order;
}
