//
//  ContentView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

struct LandingView: View {
    @StateObject private var viewModel = LandingViewModel()
    
    var title : some View {
        Text("Increment")
            .font(.system(size : 64, weight : .medium))
            .foregroundColor(.white)
    }
    
    var createButton : some View {
        Button {
            viewModel.createPushed = true
        } label : {
            HStack(alignment : .center, spacing : 15) {
                Image(systemName : "plus.circle")
                Text("Create a Challenge")
            }
            .font(.system(size : 24, weight: .semibold))
            .foregroundColor(.white)
        }
        .buttonStyle(PrimaryButtonStyle(fillColor : .primaryButton))
        .padding()
    }
    
    var alreadyButton : some View {
        Button("I already have an account") {
            // Button action
            viewModel.loginSignupPushed = true
        }.foregroundColor(.white)
    }
    
    var backgroundImage : some View {
        Image("pullup")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(Color.black.opacity(0.4))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                        .frame(height : proxy.size.height * 0.1)
                    title
                    Spacer()
                    NavigationLink(destination : CreateView(), isActive : $viewModel.createPushed) {
                        createButton
                    }
                    NavigationLink(
                        destination : LoginSignupView(viewModel: .init(mode : .login, isPushed : $viewModel.loginSignupPushed)),
                        isActive : $viewModel.loginSignupPushed)
                    {
                        alreadyButton
                    }
                } // VStack
                .padding(.bottom, 15)
                .frame(maxWidth : .infinity, maxHeight: .infinity)
                .background(
                    backgroundImage
                        .frame(width : proxy.size.width)
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
