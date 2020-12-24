//
//  myList.swift
//  app006
//
//  Created by 박규림 on 2020/12/24.
//

import SwiftUI

struct myList : View {
    
    @Binding
    var isNavigationBarHidden : Bool
    
    init(isNavigationBarHidden : Binding<Bool> = .constant(false)) {
        _isNavigationBarHidden = isNavigationBarHidden
    }
    
    
//    init() {
//        if #available(iOS 14.3, *) {
//
//        } else {
//            UITableView.appearance().tableFooterView = UIView()
//        }
//
//        UITableView.appearance().separatorStyle = .none
//    }
    
    var body : some View {
//        List {
//            Text("my List")
//            Text("my List")
//            Text("my List")
//        }
        
//        List {
//            ForEach(1...10, id : \.self) {
//                Text("my List \($0)")
//            }
//        }
        
        List {
            Section(
                header: Text("오늘 할 일")//,
                    .font(.headline)
                    .foregroundColor(Color.black)
                //footer : Text("Done")
            ){
                ForEach(1...3, id : \.self) { itemIndex in
                    myCard(icon: "swift", title: "Work Out \(itemIndex)", subTitle: "Everyday", backgroundColor: Color.green)
                }
            }.listRowInsets(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            
            Section(
                header: Text("내일 할 일")
                        .font(.headline)
                        .foregroundColor(Color.black)
            ){
                ForEach(1...3, id : \.self) { itemIndex in
                    myCard(icon: "swift", title: "Work Out \(itemIndex)", subTitle: "Everyday", backgroundColor: Color.blue)
                }
            }.listRowInsets(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            //.listRowBackground(Color.yellow)
        }
        .listStyle(GroupedListStyle())
        //.listStyle(PlainListStyle())
        .navigationTitle("My list")
        //.navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = false
        }
    }
}
