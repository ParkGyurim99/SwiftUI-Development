//
//  CardView.swift
//  Wallet
//
//  Created by Park Gyurim on 2021/08/19.
//

import SwiftUI

struct CardView: View {
    let card : Card
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(card.imageName)
                    .resizable()
                    .frame(width : 25, height : 20)
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
            Spacer()
            VStack(alignment : .trailing) {
                Text("$\(card.balance)")
                    .foregroundColor(card.textColor)
                    .fontWeight(.bold)
                Text(card.cardNumber)
                    .foregroundColor(card.textColor)
                    .font(.callout)
            }.padding(.horizontal, 5)
        }
        .padding(.vertical, 10)
        .background(card.backgroundColor)
        .cornerRadius(10)
        .frame(width : 110, height : 150)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
            .environmentObject(Wallet())
    }
}
