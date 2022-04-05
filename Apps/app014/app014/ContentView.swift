// LazyVGrid
//
//  ContentView.swift
//  app014
//
//  Created by 박규림 on 2021/01/07.
//

import SwiftUI

struct myModel : Identifiable {
    let id = UUID() //UUID를 해야 Identifiable이 적용됨
    let title : String
    let content : String
}

extension myModel {
    static var dummyDataArray : [myModel] {
        (1...2000).map{ (number : Int) in
            myModel(title: "title : \(number)", content: "content : \(number)")
        }
    } // myModel의 dummyDataArray에 접근을 하려고 하면, 뒤에 클로저가 실행되어 그 데이터들이 dummyDataArray로 들어간다.
}

struct ContentView: View {
//    let myDataArray = Array(1...2000).map({ (number : Int) in
//        return "\(number) 번"
//    })
    
    var dummyDataArray = myModel.dummyDataArray
    
    var body: some View {
        // 스크롤뷰로 감싸서 스크롤 가능하도록 설정
        ScrollView {
            // 레이지 버티컬 그리드 뷰
            // column은 호리젠탈 아이템 레이아웃을 설정하는 부분
            // 그리드 아이템 옵션 3개
            // .fixed : 고정 값
            // .adaptive : 최소 최대 값을 만족시키면서 남은 공간을 채움 (가능한 많은 item)
            // . flexible : 최소 최대 값을 만족시키면서 남은 공간을 채움 (1개 item 만)
            
//            LazyVGrid(columns: [GridItem(.fixed(200))], content: {
            LazyVGrid(columns: [
                GridItem(.fixed(100))
                ,GridItem(.fixed(200))
//                ,GridItem(.flexible(minimum: 100))
            ], spacing : 100 ,content: {
                ForEach(dummyDataArray, content : { (dataItem : myModel) in
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(height: 120)
                        .overlay(
                            Text(dataItem.title)
                        )
                })
            }) // LazyVGrid
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
