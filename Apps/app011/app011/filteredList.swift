//
//  filteredList.swift
//  app011
//
//  Created by 박규림 on 2021/01/03.
//

import SwiftUI

enum school : String, CaseIterable {
    case elementry = "Elementry School"
    case middle = "Middle School"
    case high = "High School"
}

struct myFriend : Identifiable, Hashable {
    var id = UUID()
    var name : String
    var school : school
}

struct filteredList : View {
    @State private var index = school.elementry
    @State private var myFriendsList = [myFriend]()
    
    // 생성자 메소드 -> myFriendsList 만들기
    init() {
        var newList = [myFriend]()
        
        for i in 0..<20 {
            let newFriend = myFriend(name : "friend \(i)", school : school.allCases.randomElement()!)
            newList.append(newFriend)
        }
        
        _myFriendsList = State(initialValue: newList)
        // state 접근시에는 언더바
    }
    
    
    var body: some View {
        VStack {
            Text("filtered Value : \(index.rawValue)")
            List {
                Section (header : Text("when we met?")
                            //.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .font(.headline)
                ){
                    Picker("school", selection: $index) {
                        Text("ElementrySchool").tag(school.elementry)
                        Text("MiddleSchool").tag(school.middle)
                        Text("HighSchool").tag(school.high)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("")) {
                    ForEach(myFriendsList.filter{ filterTerm in
                        //$0.school == index
                        filterTerm.school == index
                    }) { friendItem in
                        GeometryReader { geometry in
                            HStack {
                                Text("name : \(friendItem.name)")
                                    .frame(width : geometry.size.width / 2)
                                Divider()
                                Text("\(friendItem.school.rawValue)")
                            }
                            
                        }
                        
                        
                        
                    }
                }
            }
        } // Vstack
    } // body
}
