//
//  ContentView.swift
//  Memorize
//
//  Created by Park Gyurim on 2021/03/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        get {
//            return Text("Hello There, world!").padding()
//        }
//        return ZStack(content : {
        HStack {
            ForEach(0..<4) { _ in
                CardView(isFaceUp: false)
            } // ForEach
        } // HStack
        .foregroundColor(.orange)
        // Overwritting to blue - fall down
        .padding()
    }
}

struct CardView : View {
    @State var isFaceUp : Bool
    
    var body : some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3.0) // 외곽선 따기
                Text("👻")
                    .font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill()
            }
        } // ZStack
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
