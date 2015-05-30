#!/usr/bin/env js
Person = function(props) {
    var my = this;

    my.name = props.name;
    my.age = props.age;
    my.color = props.color;

    my.show = function(){
        console.log("My name is %s", my.name);
    }
}

var p = new Person({ name: 'Jon', age: 39, color: "blue" });

p.show();
