//
//  ContentView.swift
//  app009
//
//  Created by 박규림 on 2020/12/31.
//

import SwiftUI

struct ContentView: View {
    @State private var inputID : String = ""
    @State private var inputPW : String = ""
    
    var body: some View {
        VStack (alignment: .center, spacing : 10) {
            Text("NAVER")
                .foregroundColor(.green)
                .fontWeight(.black)
                .font(.system(size : 50))
            
            HStack {
                //text argument 가  Binding<String> 이기때문에 바인딩 랩퍼로 감싸져있어서 달러 싸인 써야함
                TextField(" 사용자 이름", text : $inputID)
                    .autocapitalization(.none) // 자동 대문자 변환 설정 , 전부 대문자로도 가능 ㅋㅋ
                    .disableAutocorrection(true)
                    //.frame(width: 300, height: 30)
                    //.border(Color.gray, width: 1) 이거랑
                    //.cornerRadius(2) 이거대신 텍스트필드스타일 ..
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
        
                Button(action: {
                    self.inputID = ""
                }, label: {
                    if self.inputID.count > 0 {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size : 30))
                        .foregroundColor(.gray)
                    }
                })
            }
            
            
            HStack {
                SecureField(" 비밀번호", text : $inputPW)
                    //.frame(width: 300, height: 30)
                    //.border(Color.gray, width: 1)
                    //.cornerRadius(2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                Button(action: {
                    withAnimation {
                        self.inputPW = ""
                    }
                }, label: {
                    if !self.inputPW.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size : 30))
                        .foregroundColor(.gray)
                    }
                })
            }
            //Text("입력한 비밀번호 : \(inputPW)")
            
            Button(action : {
                
            }
            , label : {
                Text("로그인")
                    .foregroundColor(.green)
            })
        }.padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
