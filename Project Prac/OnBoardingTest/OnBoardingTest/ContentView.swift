//
//  ContentView.swift
//  OnBoardingTest
//
//  Created by Park Gyurim on 2022/10/24.
//

import SwiftUI

struct ContentView: View {
    
    let descriptions: [[String]] = [
        ["Trade", "second-hand items", "among foreigners in Korea."],
        ["Communicate", "about life in", "Korea and get information."],
        ["Earn", "discounts in", "our affiliated stores."]
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            // LOGO
            // Image("LOGO")
            Color.blue
                .frame(width: 44, height: 44)
                .padding()
            
            // Title
            VStack(spacing: 6) {
                Text("A foreigner-exclusive")
                Text("community app")
            }.font(.title2)
            .fontWeight(.bold)

            // Description
            ForEach(descriptions.indices, id: \.self) { index in
                HStack {
                    Image("OnBoarding_\(index)")
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(descriptions[index][0])
                                .foregroundColor(.yellow)
                                .fontWeight(.semibold)
                            Text(descriptions[index][1])
                            Spacer()
                        }
                        Text(descriptions[index][2])
                    }.foregroundColor(.gray)
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                }.padding(4)
            }
            
            Spacer()
            
            Group {
                Text("By proceeding, you agree to accept our")
                Text("Privacy & Policy, Terms of Service.") // Navigation Link
                    .fontWeight(.bold)
            }.font(.subheadline)
            .foregroundColor(.gray)
            
            Button {
                
            } label: {
                Text("Get Started")
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }.padding(8)
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                Button("Log In") {
                    // some action
                }.fontWeight(.bold)
                .foregroundColor(.yellow)
            }
            
            Spacer()
                .frame(height: UIScreen.main.bounds.height * 0.025)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
