//
//  EmojiMemoryGameView.swift -> view
//  Memorize
//
//  Created by Park Gyurim on 2021/03/12.
//  uikit app delegate

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel : EmojiMemoryGame

    var body: some View {
//        get {
//            return Text("Hello There, world!").padding()
//        }
//        return ZStack(content : {

        //HStack {
        ScrollView{
            LazyVGrid(columns : [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
            ]) {
                ForEach(viewModel.cards) { card in
                    CardView(card : card)
                        .onTapGesture {
                            viewModel.choose(card: card)
                        }
                        .frame(height : 150)
                } // ForEach
            } // HStack -> LazyVGrid
            .padding()
            .foregroundColor(Color.orange)
            // Overwritting to blue - fall down
            .font(.largeTitle)
        } // ScrollView
    }
}

struct CardView : View {
    //@State var isFaceUp : Bool
    var card : MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for : geometry.size)
        }
    }
    
    func body(for size : CGSize) -> some View {
        ZStack {
            //if isFaceUp {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: endLineWidth) // 외곽선 따기
                //Text("👻")
                Text(card.content)
            }
            else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }
        } // ZStack
        .font(.system(size : fontSize(for: size)))
//        .onTapGesture {
//            withAnimation(.easeInOut) {
//                isFaceUp.toggle()
//            }
//        }
    } // func body
    
    // MARK: - Drawing Constants
    let cornerRadius : CGFloat = 10.0
    let endLineWidth : CGFloat = 3.0
    let fontScaleFactor : CGFloat = 0.75
    func fontSize(for size : CGSize) -> CGFloat {
        min(size.height, size.width) * fontScaleFactor
    }
}




struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
