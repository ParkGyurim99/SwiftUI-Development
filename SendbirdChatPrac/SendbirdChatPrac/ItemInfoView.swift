//
//  ItemInfoView.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/25.
//

import SwiftUI

struct ItemInfoView: View {
    @StateObject private var viewModel = ItemViewViewModel()
    
    var body: some View {
        Button {
            viewModel.isChatExist(memberId: 71, postId: 40)
        } label : {
            Text("Knock now")
        }.background(
            NavigationLink(destination : Text(viewModel.receivedChatUrl), isActive: $viewModel.showChatRoom) { }
        )
    }
}

struct ItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ItemInfoView()
    }
}
