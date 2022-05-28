//
//  ContentView.swift
//  OnBoarding
//
//  Created by Park Gyurim on 2022/05/22.
//

import SwiftUI

enum OnBoarding : Int{
    case Trade = 1
    case Benefit
    case Communicate
}

struct ContentView: View {
    @State var step : OnBoarding = .Trade
    
    var onBoarding1 : some View {
        VStack(spacing : 10) {
            Image("OnBoarding1")
                .frame(height : UIScreen.main.bounds.height * 0.4)
            HStack(spacing : 0) {
                Text("Trade ")
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                Text("secondhand items")
                    .fontWeight(.bold)
            }.font(.title2)
            .frame(maxWidth : .infinity, alignment: .leading)
            Text("Can't throw away your old stuff?\nThen, trade!")
                .frame(maxWidth : .infinity, alignment: .leading)
                .foregroundColor(.gray)
        }.padding()
    }
    
    var onBoarding2 : some View {
        VStack(spacing : 10) {
            Image("OnBoarding2")
                .frame(height : UIScreen.main.bounds.height * 0.4)
            VStack {
                Text("Earn foreigners-only")
                    .fontWeight(.bold)
                    .frame(maxWidth : .infinity, alignment: .leading)
                Text("benefits")
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .frame(maxWidth : .infinity, alignment: .leading)
            }.font(.title2)
            
                
            Text("Show BridgeOn Pass,\nand get discount & free food")
                .frame(maxWidth : .infinity, alignment: .leading)
                .foregroundColor(.gray)
        }.padding()
    }
    
    var onBoarding3 : some View {
        VStack(spacing : 10) {
            Image("OnBoarding3")
                .frame(height : UIScreen.main.bounds.height * 0.4)
            VStack {
                Text("Share your story &")
                    .fontWeight(.bold)
                    .frame(maxWidth : .infinity, alignment: .leading)
                HStack(spacing : 0) {
                    Text("Communicatite ")
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    Text("with people")
                }.frame(maxWidth : .infinity, alignment: .leading)
            }.font(.title2)
            
            
            Text("You got a question?\nASK BRIDGE!")
                .frame(maxWidth : .infinity, alignment: .leading)
                .foregroundColor(.gray)
        }.padding()
    }
    
    var body: some View {
        VStack {
            Button {
                
            } label : {
                Text("Skip")
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
            }.frame(maxWidth : .infinity, alignment: .trailing)
            .padding()
            Spacer()
            TabView(selection: $step) {
                onBoarding1.tag(OnBoarding.Trade)
                onBoarding2.tag(OnBoarding.Benefit)
                onBoarding3.tag(OnBoarding.Communicate)
            }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .frame(height : UIScreen.main.bounds.height * 0.7)
            
            HStack {
                Circle().frame(width : 8)
                    .foregroundColor(step.rawValue > 0 ? .yellow : .gray)
                Circle().frame(width : 8)
                    .foregroundColor(step.rawValue > 1 ? .yellow : .gray)
                Circle().frame(width : 8)
                    .foregroundColor(step.rawValue > 2 ? .yellow : .gray)
            }.frame(height : 10)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
