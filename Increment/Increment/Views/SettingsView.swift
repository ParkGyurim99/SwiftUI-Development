//
//  SettingsView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/04.
//

import SwiftUI

struct SettingsView : View {
    @StateObject private var viewModel = SettingsViewModel()
    var body : some View {
        List(viewModel.itemViewModels.indices, id : \.self) { index in
            Button {
                viewModel.tappedItem(at : index)
            } label : {
                HStack {
                    Image(systemName: viewModel.item(at : index).iconName)
                    Text(viewModel.item(at : index).title)
                }
            }
        }
        .background(
            NavigationLink(
                destination: LoginSignupView(viewModel : .init(mode : .signup)),
                isActive : $viewModel.loginsignupPushed
            ) {
                
            }
        )
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.onAppear()
        }
    }
}
