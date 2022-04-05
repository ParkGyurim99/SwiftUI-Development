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
    
    @ViewBuilder
    private func body(for size : CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
    //            Text("\(geometry.size.width)")
    //            Text("\(geometry.size.height)")
    //            Circle()
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(.system(size : fontSize(for: size)))
            } // ZStack
            //.modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp : card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius : CGFloat = 10.0
    private let endLineWidth : CGFloat = 3
    private let fontScaleFactor : CGFloat = 0.75
    private func fontSize(for size : CGSize) -> CGFloat {
        //return
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
 
