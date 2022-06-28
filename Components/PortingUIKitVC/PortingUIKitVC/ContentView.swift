//
//  ContentView.swift
//  PortingUIKitVC
//
//  Created by Park Gyurim on 2022/06/28.
//

import SwiftUI

struct ContentView: View {
    @State var showImagePicker : Bool = false
    
    var body: some View {
        VStack {
            Button {
                showImagePicker.toggle()
            } label : {
                Text("Hello, world!")
                    .padding()
            }
        }.popover(isPresented: $showImagePicker) {
            ImagePicker()
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
