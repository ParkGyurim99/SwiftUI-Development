import Foundation

//var temp = 101.0
var temp = 10000000.0
var itemPrice : String {
    //String(format: "%.1f", post.price)
    var src = String(describing: Int(temp))
    var len = src.count
    var count = 1
    
    while (len > (4 * count - 1)) { //
        src.insert(",", at: src.index(src.endIndex, offsetBy: (4 * count - 1) * -1))
        count += 1
        len += 1
    }
    
    return src
}
print(itemPrice)
