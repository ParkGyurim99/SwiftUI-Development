//
//  app012App.swift
//  app012
//
//  Created by 박규림 on 2021/01/04.
//

import SwiftUI

@main
struct app012App: App {
    
    @State var selectedTab = tabIdentifier.toDoList
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab
                    , content: {
                        toDoListView()
                            .tabItem {
                                Image(systemName: "list.bullet")
                                Text("할 일 목록")
                            }
                            .tag(tabIdentifier.toDoList)
                                
                        profileView()
                            .tabItem {
                                Image(systemName: "person.circle.fill")
                                Text("프로필")
                            }
                            .tag(tabIdentifier.profile)
            })
                .onOpenURL(perform: { url in
                    // 열려야 하는 url 처리
                    guard let tabId = url.tabIdentifier else { return }
                    selectedTab = tabId
                })
        }
    }
}

// 어떤 탭이 선택 되었는지 ?
enum tabIdentifier : Hashable {
    case toDoList, profile
}

// 어떤 페이지를 보여줘야 하는지?
enum pageIdentifier : Hashable {
    case toDoItem(id : UUID)
}

extension URL {
    // info에서 추가한 딥링크가 들어왔는지 ? 들어왔으면 isDeeplink에 true
    var isDeepLink : Bool {
        return scheme == "deepLink-SwiftUI"
    }
    
    // url 들어오는 것으로 어떤 탭을 보여줘야하는지 가져오기
    var tabIdentifier : tabIdentifier? {
        guard isDeepLink else { return nil }
        
        // deepLink-SwiftUI://hohoho      -->> hohoho 가 host
        switch host {
        case "toDoList" :
            return .toDoList
        case "profile" :
            return .profile
        default : return nil
        }
    }
    // deepLink-SwiftUI://hohoho/hahaha   -->> hohoho가 1번째 쨰, hahaha가 2번째 .. 즉 pathcomponents.count ==2
    var detailPage : pageIdentifier? {
        guard let tabId = tabIdentifier,
              pathComponents.count > 1,
              let uuid = UUID(uuidString: pathComponents[1])
        else { return nil }
        switch tabId {
        case .toDoList:
            return .toDoItem(id: uuid)
        default:
            return nil
        }
    }
    
}
