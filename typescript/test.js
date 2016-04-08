var Employee = (function () {
    function Employee(firstname, middleinitial, lastname) {
        this.firstname = firstname;
        this.middleinitial = middleinitial;
        this.lastname = lastname;
        this.fullname = firstname + " " + middleinitial + ". " + lastname;
    }
    return Employee;
})();
function message(person) {
    return "I am " + person.firstname + " " + person.lastname;
}
var bob = new Employee("Robert", "X", "Daffodil");
console.log(message(bob));
