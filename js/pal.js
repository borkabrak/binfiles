#!/usr/bin/env node

/* 
String.prototype.is_palindrome = function(){
    // All strings of one or zero chars are palindromes
    if (this.length < 2) return true;

    // If the first and last don't match, the answer's no, otherwise test the
    // rest of the string
    return (this[0] === this[this.length - 1]) ?
        this.slice(1,this.length - 1).is_palindrome() :
        false;
}
*/

String.prototype.is_palindrome = function() {
    var str = this.toLowerCase().replace(/[^a-z]/g,""); // Ignore case and all non-letters
    return str === str.reverse();
}

String.prototype.is_palindrome2 = function() {
}

String.prototype.reverse = function() {
    return (this.length < 2) ? this.toString() : this.slice(1).reverse() + this[0];
}

var strings = [
    "",
    "a",
    "radar",
    "Radar",
    "radarx",
    "reddit",
    "madamimadam",
    "Madam, I'm Adam"
];

console.log("PALINDROME?");
strings.forEach(function(str){
    console.log("'%s': %s", str, str.is_palindrome() ? "YES" : "NO");
});
