//
//  main.swift
//  SwiftConcurrencyPrac
//
//  Created by Park Gyurim on 2023/05/11.
//

import Foundation

//struct Person: Sendable {
//    var name: String
//    var age: Int
//
//    mutating func getOld(_ year: Int = 1) {
//        age += year
//    }
//}
//
//actor Man {
//    var name: String
//    var age: Int
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//
//    func getOld(_ year: Int = 1) {
//        age += year
//    }
//
////    nonisolated func getYounger(_ year: Int = 1) {
////        age -= year
////    }
//}
//
////extension Man {
////    nonisolated func getYounger(_ year: Int = 1) {
////        age -= year
////    }
////}
//
//var person = Person(name: "Elle", age: 20)
//print(person.name, person.age)
//person.getOld()
//print(person.name, person.age)
//
//print("")
//
//var man = Man(name: "Jack", age: 25)
//await print(man.name, man.age)
//await man.getOld()
//await print(man.name, man.age)
//
//print("")
//print("EOF")
//print("")
//
//
//protocol Shape {
//    func draw() -> String
//}
//
//struct Triangle: Shape {
//    var size: Int
//    func draw() -> String {
//        var result = [String]()
//        for length in 1...size {
//            result.append(String(repeating: "*", count: length))
//        }
//        return result.joined(separator: "\n")
//    }
//}
//
//struct Square: Shape {
//    var size: Int
//    func draw() -> String {
//        let line = String(repeating: "*", count: size)
//        let result = Array<String>(repeating: line, count: size)
//        return result.joined(separator: "\n")
//    }
//}
//
//struct FlippedShape<T: Shape>: Shape {
//    var shape: T
//    func draw() -> String {
//        let lines = shape.draw().split(separator: "\n")
//        return lines.reversed().joined(separator: "\n")
//    }
//}
//struct JoinedShape<T: Shape, U: Shape>: Shape {
//    var top: T
//    var bottom: U
//    func draw() -> String {
//        return top.draw() + "\n" + bottom.draw()
//    }
//}
//
//
//func flip<T: Shape>(_ shape: T) -> some Shape {
//    return FlippedShape(shape: shape)
//}
//
//func join<T: Shape, U: Shape>(_ shape1: T, _ shape2: U) -> some Shape {
//    return JoinedShape(top: shape1, bottom: shape2)
//}
//
//func makeTrapezoid() -> some Shape { // 반환 값의 실제 타입은 가려집니다.
//    let top = Triangle(size: 2)
//    let middle = Square(size: 2)
//    let bottom = flip(top)
//    let trapezoid = JoinedShape(
//        top: top,
//        bottom: join(middle, bottom)
//    )
//    return trapezoid
//}

//protocol Nationality {
//    var rawValue: String { get }
//    func desc()
//
//    func hello() -> String
//    func compliment() -> String
//}
//
//struct English: Nationality {
//    var rawValue: String = "English"
//    func desc() { print(rawValue) }
//
//    func hello() -> String { "Hi" }
//    func compliment()-> String { "Great" }
//}
//
//struct Korean: Nationality {
//    var rawValue: String = "Korean"
//    func desc() { print(rawValue) }
//
//    func hello() -> String { "An-nyeong" }
//    func compliment() -> String { "Pom-micheotdai" }
//    func bye() -> String { "Jal-ga" }
//}
//
//func temp(natoinality: some Nationality) {
//    /// swift5.7 ~
//    /// opaque type can be used as parameter type
//}
//
//struct MixedNationality<R1: Nationality, R2: Nationality>: Nationality {
//    var rawValue: String = "Korean-English"
//    func desc() { print(rawValue) }
//    var temp: some Nationality = Korean()
//
//    func hello() -> String { "HelloAnyeong" }
//    func compliment() -> String { "GoodGood" }
//
//    func babyNationality(choice: Nation) -> some Nationality {
//        return Korean()
////        switch choice {
////        case .Korea: return Korean()
////        case .England: return English()
////        }
//    }
//}
//
//enum Nation {
//    case Korea
//    case England
//}
//
//let mixed = MixedNationality<Korean, English>()
//let mixedBaby = mixed.babyNationality(choice: .England)
//mixedBaby.desc()
//print(type(of: mixedBaby))
//print(type(of: mixed))
//
//func temp<T: Nationality>(t: T) -> Nationality {
//    return Korean()
//}
//let kk = temp(t: Korean())
//// → Don't preserve type identity
//
//func temp2<T: Nationality>(t: T) -> some Nationality {
//    return Korean()
//}
//let kkk = temp2(t: Korean())
//
//func makeArray() -> some Collection {
////    return [] // type → Array<Any>
////    return [1,2,3] // type → Array<Int>
//    return ["a", "b", "c"] // type → Array<String>
//}
//
//
//let array = makeArray()
//print(type(of: array))
//
///// REF:
///// https://zeddios.tistory.com/1366
///// https://eunjin3786.tistory.com/490
//
//func ttee() async {
//    await withThrowingTaskGroup(of: Void.self) { group in
//        group.addTask {
//
//        }
//
//    }
//    await withTaskGroup(of: Void.self) { temp in
//
//    }
//}
//
//let someTask = Task { }
//someTask.cancel()

struct Blog {
    static let domain: String = "www.blog.com"
    let author: String
    
    func facotry(name: String) -> Self { Self.init(author: name) }
}

let blog = Blog(author: "Gyurim")
print(type(of: blog)) // Blog
print(type(of: type(of: blog))) // Blog.Type
print(Blog.domain) // www.blog.com
print(type(of: blog).domain) // www.blog.com
print(Blog.self.domain) // www.blog.com

print(Blog.Type.self) // Blog.Type
print(Blog.self) // Blog
let blogType: Blog.Type = Blog.self
print(blogType) // Blog

func genericFunction<T>(ofType: T.Type, value: T) -> T {
    let someValue: T = value
    if ofType == Blog.self { print("✅", Blog.domain) }
    
    return someValue
}

func genericFunc<T>(value: T) -> T {
    let someValue: T = value
    return someValue
}

func genericTypeFunction<T>(ofType: T.Type) -> T.Type {
    return ofType
}

print(genericFunction(ofType: Int.self, value: 10))
print(genericFunction(ofType: String.self, value: "sss"))
print(genericFunc(value: 10))
print(genericFunc(value: "sss"))
//print(genericFunction(ofType: "String"))
//print(genericFunction(ofType: 10))
//print(genericFunction(ofType: "String"))

print(genericTypeFunction(ofType: Int.Type.self))
print(genericTypeFunction(ofType: String.self))

let typeOfBlog: Blog.Type = Blog.self
print(Blog.domain)
print(Blog.self.domain)

_ = genericFunction(ofType: Blog.self, value: blog)

let str: String = "--"
print(str)
print(str.self)
print(type(of: str))
let strType: String.Type = String.self
let someStr = strType.init(describing: "dddd")
print(someStr)
