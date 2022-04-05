//
//  TextStyle.swift
//  WIT
//
//  Created by LEESEUNGMIN on 2021/05/21.
//

import SwiftUI

extension Text {
    func stylePrimary() -> some View{
        self
            .fontWeight(.bold)
            .font(.system(size: 13))
            .foregroundColor(Color.black)
    }
    func styleSecondary() -> some View{
        self
            .font(.system(size: 12))
            .foregroundColor(Color.black)
    }
    func styleTertiary() -> some View{
        self
            .font(.system(size: 12))
            .foregroundColor(Color.gray)
    }
}
