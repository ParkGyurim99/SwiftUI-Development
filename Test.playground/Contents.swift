import UIKit

func sorted(by order: (Int, Int) -> Bool) -> Int {
    if order(1, 2) {
        return 1
    } else {
        return 0
    }
}

func printX() -> () {
    print(sorted { a, b in
        return a != b
    })
}

print(printX())
