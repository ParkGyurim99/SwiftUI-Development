//
//  WalletApp.swift
//  Wallet
//
//  Created by Park Gyurim on 2021/08/19.
//
// reference : https://www.youtube.com/watch?v=4AD74MAAx58
// reference : https://www.youtube.com/watch?v=hrdbPGpWEoI
//

import SwiftUI

@main
struct WalletApp: App {
    @StateObject private var wallet = Wallet()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wallet) // app 전체에서 공유 -> CardListView 에서 EnvironmentObject로 사용함
        }
    }
}

final class Wallet : ObservableObject {
    @Published var cards = cardData
    
    var selectedCard : Card {
        cards.first(where : {$0.isSelected})!
        // 조건을 만족하는 첫번째 element return ( wrapping 된 상태로 )
    }
}
