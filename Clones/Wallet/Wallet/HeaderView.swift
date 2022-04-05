//
//  HeaderView.swift
//  Wallet
//
//  Created by Park Gyurim on 2021/08/19.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning,")
                    .font(.callout)
                    .foregroundColor(Color(.systemGray3))
                Text("GYURIM PARK")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            Image("user")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
