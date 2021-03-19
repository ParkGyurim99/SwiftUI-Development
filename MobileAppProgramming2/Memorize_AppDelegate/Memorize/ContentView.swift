//
//  ContentView.swift
//  Memorize
//
//  Created by Park Gyurim on 2021/03/12.
//  uikit app delegate

import SwiftUI

struct ContentView: View {
    var viewModel : EmojiMemoryGame
    
    var body: some View {
//        get {
//            return Text("Hello There, world!").padding()
//        }
//        return ZStack(content : {
        
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card : card)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
            } // ForEach
        } // HStack
        .padding()
        .foregroundColor(Color.orange)
        // Overwritting to blue - fall down
        .font(.largeTitle)
    }
}

struct CardView : View {
    //@State var isFaceUp : Bool
    var card : MemoryGame<String>.Card
    
    var body : some View {
        ZStack {
            //if isFaceUp {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3.0) // 외곽선 따기
                //Text("👻")
                Text(card.content)
                    .font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill()
            }
        } // ZStack
//        .onTapGesture {
//            withAnimation(.easeInOut) {
//                isFaceUp.toggle()
//            }
//        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
