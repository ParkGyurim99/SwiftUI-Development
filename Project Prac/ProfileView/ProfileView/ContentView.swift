//
//  ContentView.swift
//  ProfileView
//
//  Created by Park Gyurim on 2022/09/01.
//

import SwiftUI

struct ChipButtonStyle: ViewModifier {
    private var color: Color
    private var cornerRadius: CGFloat
    private var fontSize: CGFloat
    
    init(color: Color, cornerRadius: CGFloat = 20, fontSize: CGFloat = 12) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.fontSize = fontSize
    }
    
    func body(content: Content) -> some View {
        return content
            .foregroundColor(color)
            .font(.system(size: fontSize))
            .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: 1)
            )
    }
}

struct UserInformationRow: View {
    private let userName = "UserName"
    private let userDescription = "Description"
    
    var body: some View {
        HStack(spacing: 20) {
            Color.gray
                .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                .clipShape(Circle())
                
            
            VStack(alignment: .leading, spacing: 10) {
                Text(userName)
                    .font(.system(size: 20, weight: .bold))
                    .minimumScaleFactor(0.4)
                    .lineLimit(1)
                Text(userDescription)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
            NavigationLink(destination: Text("DD")) {
                Text("Edit").modifier(ChipButtonStyle(color: Color.gray))
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Profile")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "arrow.backward").opacity(0)
                }.padding()
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))

                ScrollView {
                    VStack(spacing: 20) {
                        UserInformationRow()
                        NavigationLink(destination: Text("")) {
                            Text("Check Items")
                                .padding(8)
                                .frame(maxWidth: .infinity)
                                .modifier(ChipButtonStyle(color: Color.gray, cornerRadius: 12, fontSize: 14))
                        }
                        Color.gray.opacity(0.2).frame(height: 4)
                        
                        NavigationLink(destination: Text("Sold Items")) {
                            HStack {
                                HStack {
                                    Text("Sold Items")
                                        .fontWeight(.medium)
                                    Text("10")
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.foregroundColor(Color.black)
                        }
                        Divider()
                        NavigationLink(destination: Text("Society Posts")) {
                            HStack {
                                HStack {
                                    Text("Society Posts")
                                        .fontWeight(.medium)
                                    Text("20")
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.foregroundColor(Color.black)
                        }
                    }.padding()
                }
            }.navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
