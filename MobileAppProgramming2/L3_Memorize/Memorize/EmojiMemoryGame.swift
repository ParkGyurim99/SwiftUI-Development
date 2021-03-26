//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by knuprime109 on 2021/03/17.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count){ pairIndex in
                return emojis[pairIndex]
        }
    }

    // MARK: - Access to the Model

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }

    // MARK: - Intent(s)

    func choose(card: MemoryGame<String>.Card){
        //objectWillChange.send()
        model.choose(card: card)
    }
}

