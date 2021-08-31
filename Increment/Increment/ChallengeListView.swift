//
//  ChallengeListView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/31.
//

import SwiftUI

struct ChallengeListView : View {
    @StateObject private var viewModel : ChallengeListViewModel = ChallengeListViewModel()
    
    var body : some View {
        Text("Challenge List")
    }
}
