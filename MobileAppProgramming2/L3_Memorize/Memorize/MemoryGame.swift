//
//  MemoryGame.swift
//  Memorize
//
//  Created by knuprime109 on 2021/03/17.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>

    mutating func choose(card : Card) {
        print("card chosen : \(card)") // String interpolation
        let chosenIndex = self.index(of : card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    
    }
    
    func index(of card : Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO : Bogus
    }
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }

    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

