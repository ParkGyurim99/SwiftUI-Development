//
//  TabContainerView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/31.
//

import SwiftUI

struct TabContainerView : View {
    @StateObject private var tabContainerViewModel = TabContainerViewModel()
    
    var body : some View {
        TabView(selection : $tabContainerViewModel.selectedTab) {
            ForEach(tabContainerViewModel.tabItemViewModels, id : \.self) { viewModel in
                tabView(for : viewModel.type)
                    .tabItem {
                        Image(systemName : viewModel.imageName)
                        Text(viewModel.title)
                    }.tag(viewModel.type)
            }
        }.accentColor(.primary)
    }
    
    @ViewBuilder // we don't have to erase to any view, we can simply return whatever view we want // and Don't need to return because of @ViewBuilder.
    func tabView(for tabItemType : TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .log :
            NavigationView {
                LogView()
            }
        case .challengeList :
            NavigationView {
                ChallengeListView()
            }
        case .settings :
            NavigationView {
                SettingsView()
            }
        }
    }
}

final class TabContainerViewModel : ObservableObject {
    @Published var selectedTab : TabItemViewModel.TabItemType = .challengeList
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "book", title: "Activity Log", type: .log),
        TabItemViewModel(imageName: "list.bullet", title: "Challenges", type: .challengeList),
        TabItemViewModel(imageName: "gear", title: "Settings", type: .settings)
    ] // reason why i write this : i can just keep adding if i want to add more tab, and view will update accordingly
}

struct TabItemViewModel : Hashable {
    let imageName : String
    let title : String
    let type : TabItemType
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
}
