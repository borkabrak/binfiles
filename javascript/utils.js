/**
 * Useful functions
 */
"use strict";

// SHORTCUT FUNCTIONS
//
//     to_a() - casts input to an array.  Works for NodeList (returned by
//         querySelectorAll), DOMTokenList (returned by classList), etc.
var to_a = (list) => Array.prototype.slice.call(list);
var qs   = (selector) => document.querySelector(selector);

// This returns an Array, not a nodelist
var qsa  = (selector) => to_a(document.querySelectorAll(selector));

// querySelector/All() exist on both document and on Element, so let's
// duplicate the shortcuts on the Element prototype.
Element.prototype.qs = Element.prototype.querySelector;
Element.prototype.qsa = function(selector) {
    return to_a(this.querySelectorAll(selector));
}

// hoist shortcuts to global scope for debugging
window.qs = qs; window.qsa = qsa; window.to_a = to_a;

var Utils = {
    prototype_chain: function(obj) {
        // return the prototype chain of the given object as an array
        if (obj.__proto__ === null) { return []}
        return Utils.prototype_chain(obj.__proto__).unshift(obj.name);
    }
}
