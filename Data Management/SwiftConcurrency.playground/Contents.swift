import Foundation

struct Person: Sendable {
    var name: String
    var age: Int
}

actor Man {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func getOld(_ year: Int = 1) async {
        age += year
    }
}

var person = Person(name: "L", age: 20)
print(person.name)

var man = Man(name: "J", age: 25)
await print(man.age)
await man.getOld()
await print(man.age)
print("EOF")
