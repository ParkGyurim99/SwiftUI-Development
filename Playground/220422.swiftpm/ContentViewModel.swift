//
//  ContentViewModel.swift
//  220422
//
//  Created by Park Gyurim on 2022/04/23.
//

import SwiftUI

final class ContentViewModel : ObservableObject {
    @Published var isLoading : Bool = true
    
    @Published var cards : [CardInfo] = []
    @Published var targetNumber : Int = 0
    
    @Published var showGuide : Bool = false
    
    @Published var alertType : AlertType = .Success
    @Published var showAlert : Bool = false
    
    // For Reset task
    var cardsBackup : [CardInfo] = []
    var targetNumberBackup : Int = 0
    
    var cardPositions : [CGPoint] = []
    
    let countOfCards : Int
    let operationType : OperationType
    
    init(n : Int, operation : OperationType) {
        countOfCards = n
        operationType = operation
        cards = Array<CardInfo>(repeating: CardInfo(x: 0, y: 0), count: n)
        makeCards(n: n, opType : operation, cards: &cards) { self.isLoading = false }
        makeTimeMachine()
    }
    
    func makeCards(n : Int,
                   opType : OperationType,
                   cards : inout [CardInfo],
                   completion : @escaping () -> ()
    ) {
        var positions : [CGPoint] = []
        
        let firstRowCount = n / 2
        let secondRowCount = n - n/2
        
        let firstRowPositionUnit = Device.halfWidth / CGFloat(firstRowCount + 1)
        let secondRowPositionUnit = Device.halfWidth / CGFloat(secondRowCount + 1)
        
        let firstRowY = (Device.height * 1) / 3
        let secondRowY = (Device.height * 2) / 3
        
        // for First Row
        for i in 0..<firstRowCount {
            positions.append(CGPoint(x: firstRowPositionUnit * CGFloat((i + 1)), y: firstRowY))
        }
        
        // for Second Row
        for i in firstRowCount..<n {
            positions.append(CGPoint(x: secondRowPositionUnit * CGFloat(i + 1 - firstRowCount), y: secondRowY))
        }
        
        //return positions // Count of positions must be same with n
        for i in 0..<n {
            cards[i].position.width = positions[i].x
            cards[i].position.height = positions[i].y
        }
        
        cardPositions = positions
        
        // make number set
        switch opType {
            case .Plus :
                var opIndex : [Int] = []
                var opCount = Int(arc4random()) % (n/2)
                
                while (opCount > 0) {
                    let index = Int(arc4random()) % n
                    if opIndex.contains(index) {
                        continue
                    } else {
                        opIndex.append(index)
                        opCount -= 1
                    }
                }
                
                var sum = 0
                for i in 0..<n {
                    let temp = arc4random() % 15 + 1
                    cards[i].number = Int(temp)
                    sum += Int(temp)
                }
                targetNumber = sum
                opIndex.forEach { i in
                    targetNumber -= cards[i].number
                }
                
            case .Minus :
                targetNumber = Int(arc4random() % 20 + 20)
                let opCount = Int(arc4random()) % (n/2) + 1 // k
                
                var tempArr = Array<Int>(repeating: 0, count: n)
                var sum = targetNumber
                for i in 1...opCount {
                    let temp = arc4random() % 15 + 1
                    tempArr[n - i] = Int(temp)
                    sum += Int(temp)
                }
                for i in 0..<sum { tempArr[i % (n - opCount)] += 1 }
                
                tempArr.shuffle()
                for i in 0..<n {
                    cards[i].number = tempArr[i]
                }
                
            case .Multiply :
                var opIndex : [Int] = []
                var opCount = Int (arc4random()) % n + 1 // k
                var sum = 0
                var index = n - 1
                
                while (opCount > 0) {
                    let index = Int(arc4random()) % n + 1
                    if opIndex.contains(index) {
                        continue
                    } else {
                        opIndex.append(index)
                        opCount -= 1
                    }
                }
                
                while (index >= 0) {
                    if opIndex.contains(index) {
                        cards[index].number = Int(arc4random()) % 9 + 1
                        cards[index - 1].number = Int(arc4random()) % 9 + 1
                        sum += cards[index].number * cards[index - 1].number
                        index -= 2
                    } else {
                        cards[index].number = Int(arc4random()) % 9 + 1
                        sum += cards[index].number
                        index -= 1
                    }
                }
                targetNumber = sum
                
            case .Divide :
                let opCount = Int (arc4random()) % (n/2) + 1 // k
                var sum = 0
                var tempArr : [Int] = Array<Int>(repeating: 1, count: n)
                for i in 0..<(n-opCount) {
                    tempArr[i] = Int(arc4random()) % 7 + 2
                    sum += tempArr[i]
                }
                for i in 0..<opCount {
                    let divisor = Int(arc4random()) % 7 + 2
                    tempArr[i + n - opCount] = tempArr[i] * divisor
                    //sum -= tempArr[i]
                    sum += (divisor - tempArr[i])
                }
                
                targetNumber = sum
                tempArr.shuffle()
                
                for i in 0..<n { cards[i].number = tempArr[i] }
        }
        
        completion()
    }
    
    func checkThePoint(current : CGPoint, currentIndex : Int) -> Int? {
        for index in 0..<countOfCards {
            if currentIndex == index { continue }
            if (cardPositions[index].x - 20)..<(cardPositions[index].x + 20) ~= current.x &&
                (cardPositions[index].y - 30)..<(cardPositions[index].y + 30) ~= current.y {
                if cards[index].opacity != 0 {
                    return index
                }
            }
        }
        
        return nil
    }
    
    func makeTimeMachine() {
        cardsBackup = cards
        targetNumberBackup = targetNumber
    }
    
    func resetCards() {
        withAnimation {
            cards = cardsBackup
            targetNumber = targetNumberBackup
        }
    }
}
