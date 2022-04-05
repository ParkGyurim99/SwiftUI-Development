//
//  ContentView.swift
//  app013
//
//  Created by 박규림 on 2021/01/06.
//

import SwiftUI

let picker = ["picker1", "picker2", "picker3"]

struct ContentView: View {
    @State private var shouldShowAlert : Bool = false
    @State private var myText : String = ""
    @State private var selected : Int = 0
    
    var body: some View {
        NavigationView {
            
            VStack (spacing : 20) {
                Text("selected value \n: \(picker[selected])")
                    .font(.system(size : 40))
                    //.fontWeight(.bold)
                    .bold()
               Text("press ellipsis button!")
            }
                .navigationTitle("Hello")
                .toolbar(content: {
                    ToolbarItem(placement: .primaryAction, content: {
                        Menu( // 약간 Vstack 처럼 생각하고 안에 만들면 된다ㅣ.
                            content: {
                                Button(action: {
                                    print("button1 clicked!")
                                    shouldShowAlert = true
                                    myText = "Happy New Year"
                                }, label: {
                                    Label("Button1", systemImage: "flame")
                                })
                                
                                // multi trailing closer
                                // 맨 마지막 파라미터 생략하고 괄호 뒤에 쓴 것 처럼
                                // 앞에 파라미터도 생략하고 괄호 해도 됨.
                                Button {
                                    print("button2 clicked!")
                                } label : {
                                    Label("Button2", systemImage: "flame.fill")
                                }
                                
                            
                                Section {
                                    Button {
                                    } label : {
                                        Label("Button3", systemImage: "doc")
                                    }
                                    Button {
                                    } label : {
                                        Label("Button4", systemImage: "doc.fill")
                                    }
                                }
                                Picker(selection : $selected, label : Text("select animal")) {
                                    ForEach(picker.indices, id : \.self, content : { index in
                                        // indices는 index의 복수형 ..
                                        // indices를 썻기 때문에 index in 을 써서 index 쓰는거임
                                        Text("\(picker[index])")
                                    })
                                }
                                
                            }, label: {
                                Circle()
                                    .foregroundColor(Color.init(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                                    .frame(width : 50, height: 50)
                                    .overlay(
                                        Label("더보기", systemImage: "ellipsis")
                                            .font(.system(size : 30))
                                            .foregroundColor(.white)
                                    )
                        }) // menu
                        
                    }) // toolbar item
                    
                }) // toolbar
                .alert(isPresented: $shouldShowAlert, content: {
                    Alert(title: Text("Button1 Alert"), message: Text(myText), dismissButton: .default(Text("confirm")))
                })
        } // Navigation View
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
