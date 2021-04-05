//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by knuprime109 on 2021/03/17.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
//        HStack {
//            ForEach(viewModel.cards){ card in
        Grid(viewModel.cards, viewForItem: { card in
                CardView(card: card)
                    .onTapGesture {
                        viewModel.choose(card: card)
                        //self.viewModel.choose(card: card)  // 구 버전의 swift에서 self필요
                    }
                    .padding(5)
            })
            .padding()
            .foregroundColor(Color.orange)
            //.font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for : geometry.size)
        }
    }
    
    func body(for size : CGSize) -> some View {
        ZStack {
//                Text("\(geometry.size.width)")
//                Text("\(geometry.size.height)")
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: endLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        //.font(Font.largeTitle)
        .font(.system(size : fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    let cornerRadius : CGFloat = 10.0
    let endLineWidth : CGFloat = 3
    let fontScaleFactor : CGFloat = 0.75
    func fontSize(for size : CGSize) -> CGFloat {
        //return
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
 
