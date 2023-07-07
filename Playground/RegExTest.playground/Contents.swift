import UIKit

var greeting = "Hello, playground"
let regex = "(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).+"

let inputString = "abc@23"
let isMatch = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: inputString)
print(isMatch) // Output: true
