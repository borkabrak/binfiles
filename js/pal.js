#!/usr/bin/env node

String.prototype.is_palindrome = function(){
    // All strings of one or zero chars are palindromes
    if (this.length < 2) return true;

    // If the first and last don't match, the answer's no, otherwise test the
    // rest of the string
    return (this[0] === this[this.length - 1]) ?
        this.slice(1,this.length - 1).is_palindrome() :
        false;
}

var strings = [
    "",
    "a",
    "radar",
    "radarx",
    "reddit",
    "madamimadam"
];

strings.forEach(function(str){
    console.log("'%s' is%s a palindrome",str, str.is_palindrome() ? "" : " NOT");
});
