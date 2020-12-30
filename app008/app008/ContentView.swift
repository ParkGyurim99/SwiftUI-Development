//
//  ContentView.swift
//  app008
//
//  Created by 박규림 on 2020/12/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing : 30) {
            Button(action: {
                print("Clicked")
            }, label: {
                Text("탭")
            }
            ).buttonStyle(myButtonStyle(buttonColor: Color.blue, type: .tab))
            
            Button(action: {
                print("Clicked")
            }, label: {
                Text("롱클릭")
            }
            ).buttonStyle(myButtonStyle(buttonColor: Color.green, type: .long))
            
            Button(action: {
                print("Clicked")
            }, label: {
                Text("회전버튼")
            }
            ).buttonStyle(myRotateButtonStyle(buttonColor: .pink))
            
            Button(action: {
                print("Clicked")
            }, label: {
                Text("축소버튼")
            }
            ).buttonStyle(mySmallerButtonStyle(buttonColor: .yellow))
            
            Button(action: {
                print("Clicked")
            }, label: {
                Text("블러버튼")
            }
            ).buttonStyle(myBlurButtonStyle(buttonColor: .black))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
