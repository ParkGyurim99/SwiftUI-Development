//
//  ContentView.swift
//  Wallet
//
//  Created by Park Gyurim on 2021/08/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing : 35) {
                HeaderView()
                CardListView()
                BalanceView()
                TransferMoneyView()
            }.padding(25)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Wallet())
    }
}
