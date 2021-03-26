//
//  EmojiMemoryGame.swift -> View Model
//  Memorize
//
//  Created by Park Gyurim on 2021/03/19.
//

import SwiftUI

//func createCardContent(pairIndex : Int) -> String {
//    return "😁"
//} model 선언시 클로저로

class EmojiMemoryGame : ObservableObject {
    @Published private var model : MemoryGame<String> // Generic type CardContent 가 String 타입으로 결정되었음
    // class 로 선언하면 접근이 쉽기 때문에 private으로 선언하고 (set) 설정으로 read-only 상태 (glass door)
        //= MemoryGame<String>(numberOfPairsOfCard : 2, cardContentFactory: createCardContent)
        //= MemoryGame<String>(numberOfPairsOfCard : 2) { _ in "😁" } // lecture2 page 22 closure
        = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis : Array<String> = ["👻", "🎃", "🕷", "❤️", "☠️", "👺"]
        let randomNumberOfCard = Int.random(in: 2...6)
        //let clippedEmojis = emojis[0..<randomNumberOfCard]
        
        return MemoryGame<String>(numberOfPairsOfCard : emojis[0..<randomNumberOfCard].count) {
            pairIndex in emojis[0..<randomNumberOfCard][pairIndex]
        }
        //return MemoryGame<String>(numberOfPairsOfCard : clippedEmojis.count) { pairIndex in clippedEmojis[pairIndex]}
    }
    
    
    // MARK: - Access to the Model
    var cards : Array<MemoryGame<String>.Card> {
        return model.cards
    } // -> Computed var 계산 프로퍼티
    
    // MARK: - Intent(s)
    func choose(card : MemoryGame<String>.Card) {
        model.choose(card : card)
    }
}
