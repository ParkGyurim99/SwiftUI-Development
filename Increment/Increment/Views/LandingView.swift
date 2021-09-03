//
//  ContentView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

struct LandingView: View {
    @State private var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                        .frame(height : proxy.size.height * 0.1)
                    Text("Increment")
                        .font(.system(size : 64, weight : .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination : CreateView(), isActive : $isActive) {
                        Button { isActive = true } label : {
                            HStack(alignment : .center, spacing : 15) {
                                Image(systemName : "plus.circle")
                                Text("Create a Challenge")
                            }
                            .frame(width : proxy.size.width * 0.7)
                            .font(.system(size : 24, weight: .semibold))
                            .foregroundColor(.white)
                        }
                        .buttonStyle(PrimaryButtonStyle(fillColor : .primaryButton))
                        .padding()
                    }
                } // VStack
                .frame(maxWidth : .infinity, maxHeight: .infinity)
                .background(
                    Image("pullup")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width : proxy.size.width)
                        .overlay(Color.black.opacity(0.4))
                        .edgesIgnoringSafeArea(.all)
                )
            } // Geometry Reader
        } // NavigationView
        .accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .previewDevice("iPhone 8")
        
        LandingView()
            .previewDevice("iPhone 12")
    }
}
