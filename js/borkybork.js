/* 
Personal javascript library.
==============================================================================
This file contains extensions to the javascript object hierarchy.  This is
the copy I use to work, and SHOULD NOT be left in an unstable state.
*/
// String
//==============================================================================
String.prototype.wrap2array = function(max_length) {
// Wrap string to <max_length>
//
// Return an array of strings, each no longer than max_length
//
// * Break in the middle of a word if we have to -- prioritize remaining under max width
max_length = max_length || 78;
var lines = [];
var current_line = "";
this.split(/\s+/).forEach(function(word) {
  if (word.length > max_length) {
    lines.push(word.split(/.{max_length}/));
    } else if (current_line.length + word.length > max_length && current_line !== "") {
    lines.push(current_line.slice(0,-1));
    current_line = "";
    };
  current_line += word + " ";
  });
lines.push(current_line);
return lines;
}
///
// Write my own version of sprintf?
///
String.prototype.wrap = function(max_length, newline) {
// Wrap string to <max_length>, breaking only on spaces.  Return the
// string, with <newline>s (default "\n") interpolated where appropriate.
max_length = max_length || 78;
newline = newline || "\n";
var new_string = "";
this.split(/\s+/).forEach(function(word) {
  console.log("word:%s", word);
  var line_length = new_string.split(newline).slice(-1)[0].length // distance from last newline to end
  new_string += word + (line_length + word.length > max_length  ? newline : " ");
  });
return new_string.slice(0,-1);
}
String.prototype.reverse = function(){
//Another way to reverse a string is to use Array's reverse:
//  "this.split('').reverse().join('')"; 
//but that's boring, and recursion is fun!
if (this.length < 2) { return this.toString() };
return this.slice(-1) + this.slice(0,-1).reverse();
}
String.prototype.is_palindrome = function(){
return this.toString() === this.reverse();
}
String.prototype.to_decimal = function(radix){
radix = radix || 2;
console.log("radix:'%s'", radix);
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
//
//  WHOA.  It turns out to be considered Very Bad to extend Object prototype,
//  for what appear to be good reasons.  I should make my own object that
//  offers this functionality, I guess..
/*
Object.dc_create = function(o) {
//
//   True prototypal inheritance, instead of pseudo-classical inheritance.
//   Objects inherit directly from other objects, instead of having classes
//   to act as intermediaries.
//       newObject = Object.create(oldObject);
//   Gleaned from Douglas Crockford's recommendation at:
//       
//       http://javascript.crockford.com/prototypal.html
//   Browser vendors have subsequently implemented an Object.create.
//   Contrast and compare at:
//       https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Object/create
function F() {}
F.prototype = o;
return new F();
}
*/
//=========================
//  UTILITY FUNCTIONS
//=========================
var jdc = {
// recursively walk every node in an object, calling a function on each property.
walk: function(object, func){
  for(i in object){
    if (object.hasOwnProperty(i)){
      if (typeof object[i] === "object"){
        this.walk(object[i], func);
        } else {
        func(i,object);
        };
      };
    };
  },
contains: function(object, target_property){
  // Return whether this object contains the given property, at any point in
  // its hierarchy.
   
  var my = this;
  var retval = false;
  this.walk(object, function(current_property,obj){
    if (current_property === target_property){
      retval = true;
      }
    });
  return retval;
  },
/* 
A subsection of color-oriented utility functions
*/
color: {
  lighter: function(rgbstring, amount){
    /* Change <color> by <amount>
     
    * <color> is an RGB color string (short or long)
    * <amount> is a hex value between '0' and 'ff'
    It's called 'lighter', but for darker colors, give it a negative
    amount.
    */
    amount = amount || 16;
    rgbstring = rgbstring.replace(/^#/,'');
    // Handle the three-character short format (e.g. '#8a0')
    if (rgbstring.length === 3) {
      rgbstring = rgbstring.split('').join('0') + '0';
      };
    // Try to fail gracefully for some bad strings
    if (rgbstring.length !== 6) { 
      console 
      && console.log 
      && console.log("Bad color string '%s'",rgbstring);
      return '#000000'
      };
    var newstring = "#";
    // For each hue (red, green, blue)..
    rgbstring.match(/[\da-f]{2}/gi).forEach(function(color){
      // calculate the new color, staying between 0 and 255
      newcolor = parseInt(color,16) + parseInt(amount, 16);
      newcolor = (newcolor > 255) ? 255 : newcolor;
      newcolor = (newcolor < 0)   ?   0 : newcolor;
      // Don't forget leading zeros when necessary
      newstring += (newcolor < 16 ? "0" : "") + newcolor.toString(16);
      });
    return newstring;
    }
  },
};
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
for(var i = start, range = []; (end > start) ? (i < end) : (i > end); i += step){
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
var min = y ? x : 0;
var max = y || x;
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
 
For example:
 
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
       
      * ["zero", "one","two"].reorder() will reorder the array as (perhaps)
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
    // Document (DOM)
    function restyle(selector, css_properties){
      // Add/edit css properties on selected elements.
      var element, elements = document.querySelectorAll(selector);
      for (var i in elements){
        if ( !elements[i].style ) { break };
        for (var property_name in css_properties){
          elements[i].style[property_name] = css_properties[property_name];
          };
        };
      }
    Math.seq(10)
    Math.seq
    Math.seq.valueOf
    Math.seq.valueOf()
    Math.seq.toString()
    Math.seq.toString().split("\n")
    Math.seq 10
    Math.seq(99,3,3)
    Math.seq(99,0,3)
    Math.seq(99,3)
    Math.seq(0,99,3)
    ls
