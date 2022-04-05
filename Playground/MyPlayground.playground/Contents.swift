import Foundation

let src = "12314.22"
//let src = "0"

let hasNumber = Float(src)!
let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .currency //.decimal
var formatted = numberFormatter.string(from: NSNumber(value: hasNumber))

print(formatted!.dropLast())
