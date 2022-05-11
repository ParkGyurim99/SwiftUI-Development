//
//  ContentView.swift
//  PassView
//
//  Created by Park Gyurim on 2022/05/11.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

struct ContentView: View {
    let topColor = Color.init(hex : "#F8AE00")
    let bottomColor = Color.init(hex : "#F06805")
    
    func getDate() -> String{
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "YYYY.MM.dd. hh:mm a"
        let stringDate = timeFormatter.string(from: time)
        return stringDate
    }
    
    var body: some View {
        VStack(spacing : 0) {
            HStack {
                Button {
                    
                } label : {
                    Image(systemName : "arrow.backward")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Bridge Pass")
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName : "arrow.backward").opacity(0)
            }.padding()
            .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
        
            VStack {
                HStack(alignment: .top) {
                    Circle()
                        .foregroundColor(.red)
                        .frame(width : UIScreen.main.bounds.width * 0.13, height : UIScreen.main.bounds.width * 0.13)
                    Text("USERNAME")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("Member ID :")
                    Spacer()
                }
                
                HStack {
                    Text("USERNAME")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                }
            }.foregroundColor(.white)
            .padding(20)
            .frame(maxWidth : .infinity)
            .frame(height : UIScreen.main.bounds.height * 0.22)
            .background(
                LinearGradient(colors: [topColor, bottomColor], startPoint: .top, endPoint: .bottom)
                    .overlay(
                        Text("Bridge").font(.system(.largeTitle , design: .rounded))
                            .fontWeight(.black)
                            .scaleEffect(3.0)
                            .foregroundColor(.white.opacity(0.1))
                            .offset(x: UIScreen.main.bounds.width * 0.03, y: UIScreen.main.bounds.height * 0.065)
                    )
                
            )
            .cornerRadius(8)
            .padding()
            //Text("\(Date(timeIntervalSinceNow: 0).formatted(.iso8601))")
            Text(getDate())
                .foregroundColor(.gray)
                .padding(.horizontal)
                .frame(maxWidth : .infinity, alignment : .trailing)
                
            VStack {
                Text("For Store Owners:")
                    .fontWeight(.bold)
                    .padding(.vertical, 2)
                    .foregroundColor(.black.opacity(0.6))
                    .frame(maxWidth : .infinity, alignment : .leading)
                Text("BRIDGE certifies above personnel is user of BRIDGE. Please provide him benefit and the best service ")
                    .frame(maxWidth : .infinity, alignment : .leading)
            }.padding()
            .foregroundColor(.gray)
                             
            VStack {
                Text("점주분들에게:")
                    .fontWeight(.bold)
                    .padding(.vertical, 2)
                    .foregroundColor(.black.opacity(0.6))
                    .frame(maxWidth : .infinity, alignment : .leading)
                Text("BRIDGE는 위 사람이 브릿지의 유저임을 알려드립니다. 상점 주인분들께서 혜택과 좋은 서비스를 제공해주시길 부탁드리겠습니다.  ")
                    .frame(maxWidth : .infinity, alignment : .leading)
            }.padding()
            .foregroundColor(.gray)
            
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
