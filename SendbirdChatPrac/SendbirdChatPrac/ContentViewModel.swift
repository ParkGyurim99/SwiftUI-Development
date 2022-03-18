//
//  ContentViewModel.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/18.
//

import SwiftUI
import SendBirdSDK

class ContentViewModel : ObservableObject {
    @Published var text : String = ""
    @Published var showImagePicker : Bool = false
    @Published var selectedImage : UIImage? = nil
    
    func groupChannelParams() -> SBDGroupChannelParams {
        let params = SBDGroupChannelParams()
        params.name = "iOS Test Channel"
        
        return params
    }
    
    func fetchChannelList() {
        let listQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        listQuery?.limit = 15
        
        listQuery?.loadNextPage { groupChannelList, error in
            guard let _ = groupChannelList, error == nil else {
                print(error?.localizedDescription as Any)
                return // Handle error.
            }
            print(groupChannelList as Any)
            for c in groupChannelList! {
                print(c.name, c.channelUrl)
            }
            
            //self.channelList.append(contentsOf: groupChannels)
        }
    }
}
