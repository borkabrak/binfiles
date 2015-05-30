// the 'exports' object is returned when this is required as a module.
// Technically, it's the 'module.exports' object, which can be overwritten
// entirely in the case, i.e., of a constructor.
exports.speak = function(){
  console.log("Hello, universe!");
};
