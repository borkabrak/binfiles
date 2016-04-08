
class Employee {
    fullname: string;
    constructor(firstname, public middleinitial, public lastname) {
        this.fullname = firstname + " " + middleinitial + ". " + lastname;
    }
}

interface Person {
    firstname: string;
    lastname: string;
}

function message(person: Person) {
    return "I am " + person.firstname + " " + person.lastname;
}

var bob = new Employee("Robert", "X", "Daffodil");

console.log(message(bob));
