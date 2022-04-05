//
//  myPracView.swift
//  app001
//
//  Created by 박규림 on 2020/12/16.
//

import SwiftUI

struct myPracView : View {
    
    //@Binding 데이터를 연동시킴
    @Binding
    var isActivated : Bool
    
    // 생성자
    init(isActivated : Binding<Bool> = .constant(true)) {
        _isActivated = isActivated
    }
    
    var body: some View {
        HStack{
            Color.red.fixedSize()
            Color.orange.fixedSize()
            Color.yellow.fixedSize()
            Color.green.fixedSize()
            Color.blue.fixedSize()
        }.padding(10)
//        .background(isActivated ? Color.gray : nil)
//        .cornerRadius(10)
    }
}
