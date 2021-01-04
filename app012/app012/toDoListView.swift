//
//  toDoListView.swift
//  app012
//
//  Created by 박규림 on 2021/01/04.
//

import SwiftUI

struct toDoItem : Identifiable, Hashable {
    var id : UUID
    var title : String
}

func prepareData() -> [toDoItem] {
    var newList : [toDoItem] = []
    
    for i in 0..<20 {
        let newTodo = toDoItem(id : UUID(), title : "내 할일 \(i)")
        print("new toDoItem.id : \(newTodo.id), new toDoItem.title : \(newTodo.title)")
        
        newList.append(newTodo)
    }
    
     return newList
}

struct toDoListView : View {
    @State var toDoItems : [toDoItem] = []
    @State var activeUUID : UUID?
    
    //생성자 메소드
    init() {
        _toDoItems = State(initialValue: prepareData())
    }
    
    var body: some View {
        NavigationView  {
//            List {
//                ForEach (0..<20) { i in
//                    NavigationLink(destination: Text("내 할 일 \(i)"),
//                        label: {
//                            Text("내 할 일 \(i)")
//                        })
//                }
//            }.navigationBarTitle("할 일 목록")
            
            List(toDoItems) { toDoItem in
                NavigationLink(destination: Text("\(toDoItem.title)"),
                               tag: toDoItem.id,
                               // activeUUID 값이 변경 되면 해당하는 링크로 이동
                               selection: $activeUUID,
                               label: {Text("\(toDoItem.title)")}
                )
            }.navigationTitle("할 일 목록")
            .onOpenURL(perform: { url in
                if case .toDoItem(let id) = url.detailPage {
                    print("넘어온 id : \(id)")
                    activeUUID = id
                }
            })
            
            
            
        }
    }
}
