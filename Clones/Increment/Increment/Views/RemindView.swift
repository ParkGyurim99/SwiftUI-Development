//
//  RemindView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack {
            Spacer()
            Button(action : {
                
            }) {
                Text("Create")
                    .font(.system(size : 24, weight : .medium))
                    .foregroundColor(.primary)
            }
            
            Button(action : {
                
            }) {
                Text("Skip")
                    .font(.system(size : 24, weight : .medium))
                    .foregroundColor(.primary)
            }
        }.navigationTitle("Remind")
    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
        }
    }
}
