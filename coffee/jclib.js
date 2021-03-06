// Generated by CoffeeScript 1.6.2
(function() {
  var data, s, _i, _j, _len, _len1, _ref, _ref1;

  String.prototype.reverse = function() {
    if (this.length < 2) {
      return this;
    } else {
      return this[this.length - 1] + this.slice(0, -1).reverse();
    }
  };

  String.prototype.is_palindrome = function() {
    if (this.length < 2) {
      return true;
    }
    if (this[this.length - 1] !== this[0]) {
      return false;
    } else {
      return this.slice(1, -1).is_palindrome();
    }
  };

  String.prototype.is_palindrome2 = function() {
    return this.toString() === this.reverse();
  };

  String.prototype.pad = function(len, character) {
    if (len == null) {
      len = 0;
    }
    if (character == null) {
      character = "0";
    }
    character = character.toString();
    if (this.length > len) {
      return this;
    } else {
      return (this + character).pad(len, character);
    }
  };

  _ref = ["laser", "radar", "racecar", "Coffeescript is.. actually pretty badass"];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    data = _ref[_i];
    _ref1 = ["'" + data + "'..", "pad(0,'0'):'" + (data.pad(0, '0')) + "'", "pad(10,0):'" + (data.pad(0, 0)) + "'", "pad(10,' '):'" + (data.pad(10, ' ')) + "'", "pad(10,'0'):'" + (data.pad(10, '0')) + "'"];
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      s = _ref1[_j];
      console.log(s);
    }
  }

}).call(this);
