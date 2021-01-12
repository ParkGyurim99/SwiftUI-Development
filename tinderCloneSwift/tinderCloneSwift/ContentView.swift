//
//  ContentView.swift
//  tinderCloneSwift
//
//  Created by 박규림 on 2021/01/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // top stack
            HStack {
                Button {
                    
                } label : {
                    Image("profile")
                        .padding()
                }
                Spacer()
                Button {
                    
                } label : {
                    Image("tinder-icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height : 45)
                }
                Spacer()
                Button {
                    
                } label : {
                    Image("chats")
                        .padding()
                }
            }
            .padding(.horizontal)
            
            // Image Card
            ZStack {
                ForEach(Card.data.reversed()) { card in
                    CardView(card : card)
                        .padding(10)
                }
            }
            .zIndex(1)
            
            // bottom stack
            HStack (spacing : 0) {
                Button(action : {
                    
                }) {
                    Image("refresh")
                }
                Button(action : {
                    
                }) {
                    Image("dismiss")
                }
                Button(action : {
                    
                }) {
                    Image("super_like")
                }
                Button(action : {
                    
                }) {
                    Image("like")
                }
                Button(action : {
                    
                }) {
                    Image("boost")
                }
            }
        } // VStack
    }
}

struct CardView : View {
    @State var card : Card
    let cardGradient : Gradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])

    var body : some View {
        ZStack(alignment : .top) {
            Image(card.imageName).resizable()
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)

            // 정보
            VStack(alignment : .leading) {
                Spacer()
                Divider() // or use ZStack alignment as .leading
                    .frame(height : 0)
                    .opacity(0)
                HStack {
                    Text(card.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(String(card.age))
                    //Text("\(card.age)")
                        .font(.title)
                }
                Text(card.bio)
                    .font(.body)
            }
            .foregroundColor(.white)
            .padding()
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width : 150)
                    .opacity(Double(card.x))
                Spacer()
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width : 150)
                    .opacity(Double(card.x * -1))
            }
        }
        .cornerRadius(10)
        // 1 - ZStack follows the coordinates of the card model
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        // 2 - gesture recognizer updates the coordinate values of the card model
        .gesture (
            DragGesture()
                // when the user is dragging the view
                .onChanged { value in
                    withAnimation(.default) {
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }

                // when the user stop dragging
                .onEnded { value in
                    withAnimation(.interpolatingSpring(mass : 1.0, stiffness: 50, damping: 8, initialVelocity : 0)) {
                        switch value.translation.width {
                        case 0...100 :
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100 :
                            card.x = 500; card.degree = 12
                        case (-100)...(-1) :
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x < -100 :
                            card.x = -500; card.degree = -12
                        default :
                            card.x = 0; card.y = 0
                        }
                        
                    }
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
