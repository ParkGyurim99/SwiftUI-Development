//
//  main.swift
//  HelloWorld
//
//  Created by Park Gyurim on 2021/03/05.
//

import Foundation

var str1 = "Hello, Swift!"
print("Hello, Swift!")
print(Int.max)
print(Int32.max)
print(Int64.max)
var r5: UInt32 = UInt32(Int(arc4random()))
let heart : Character = "\u{2665}"

print(heart)
print("\u{103}")
print(String(heart))
print(heart == "♥") // true

var startIndex : String.Index = str1.startIndex
print(startIndex)
print(str1[startIndex..<str1.endIndex])


// index func return -> String.index
var index1 = str1.index(str1.startIndex, offsetBy: 3)
var index2 = str1.index(after : startIndex)
print(str1[str1.startIndex...index1])
print(str1[index2])

var arr1 : [Int] = [1, 2, 3]
var arr2 = Array<Int>([1, 2, 3])
print(arr1 == arr2) // true
print(arr1)
arr1 += [4, 5]
print(arr1)
arr1[3] = 5
print(arr1)
arr1.remove(at : 3)
arr1.insert(4, at: 3)
print(arr1)
arr1.removeLast(2)
print(arr1)


//Dictionary
var dic1 : [Int : String] = [1 : "first", 2 : "second", 3 : "third"]
print(dic1) // 순서 랜덤으로 출력
var dic2 = [1 : "first", 2 : "second", 3 : "third"]
print(dic1 == dic2)
var dic3 : Dictionary<Int, String> = [1 : "first", 2 : "second", 3 : "third"]
// var dic4 = [Int, String]() // Empty Dictionary Define is not available
print(dic2[1]!) // why Optional value?


//Set
var set1 : Set<Int> = [1, 2, 3]
print(set1)
var set2 : Set<Int> = [1, 3, 4]
print(set1.intersection(set2))
