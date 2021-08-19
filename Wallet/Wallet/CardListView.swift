//
//  CardListView.swift
//  Wallet
//
//  Created by Park Gyurim on 2021/08/19.
//

import SwiftUI

struct CardListView: View {
    @EnvironmentObject var wallet : Wallet
    
    var headerView : some View {
        HStack {
            Text("Your Cards")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Button {
                
            } label : {
                Text("Add new card")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }
        }
    }
    
    var body: some View {
        VStack {
            headerView
            ScrollView(.horizontal, showsIndicators : false) {
                HStack(spacing : 10) {
                    ForEach(wallet.cards.indices, id : \.self) { index in
                        //Text(wallet.cards[index].cardNumber)
                        CardView(card: wallet.cards[index])
                            .onTapGesture {
                                wallet.cards.indices.forEach {
                                    index in
                                    wallet.cards[index].isSelected = false
                                }
                                wallet.cards[index].isSelected.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
            .environmentObject(Wallet())
    }
}
