///
//  MemoryGame.swift
//  Memorize
//
//  Created by Park Gyurim on 2021/03/19.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards : Array<Card> // Generic
    
    init(numberOfPairsOfCard : Int, cardContentFactory : (Int) -> CardContent) {
                                    // function type parameter // Generic Type
        cards = []
        for pairIndex in 0..<numberOfPairsOfCard { // pais index => 0 OR 1
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id : pairIndex * 2))
            cards.append(Card(content: content, id : pairIndex * 2 + 1))
            // 1 pair 가 두장이기때문에
        }
        cards.shuffle()
    }
    
    func choose(card : Card) {
        print("card chosen : \(card)") // String interpolation
    }
    
    struct Card : Identifiable {
        var isFaceUp : Bool = true
        var isMatched : Bool = false
        var content : CardContent // Generic Type - 타입 고정이 아니라 바뀔 수 있는 타입
        // -> Array랑 같은 문법 .. 나만의 generic type
        var id : Int
    }
}
