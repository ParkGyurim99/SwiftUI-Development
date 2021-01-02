//
//  ContentView.swift
//  app010
//
//  Created by 박규림 on 2021/01/02.
//

import SwiftUI
import ExytePopupView

struct ContentView: View {
    @State var shouldShowBottomSolidMessage : Bool = false
    @State var shouldShowBottomToastMessage : Bool = false
    @State var shouldShowTopSolidMessage : Bool = false
    @State var shouldShowTopToastMessage : Bool = false
    @State var shouldShowPopUpMessage : Bool = false
    
    func createBottomSolidMessageView() -> some View {
        HStack (spacing : 10) {
            Image(systemName : "scribble.variable")
                .font(.system(size : 40))
                .foregroundColor(.white)
            VStack (alignment : .leading) {
                Text("Qu'est-ce que le Lorem Ipsum?")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. ")
                    .lineLimit(2)
                    .font(.system(size : 15))
                    .foregroundColor(.white)
                
                Divider() // 그림과 글자 비율을 맞추기 위해서/ // 그림 : 글글글글
                    .opacity(0)
            }
        }
        .frame(width : UIScreen.main.bounds.width)
        .padding()
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : 15)
        .background(Color.purple)
    }
    
    func createBottomToastMessageView() -> some View {
        HStack (alignment : .top, spacing : 10) {
            Image("benz")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .offset(y : -10)
                .frame(width: 60, height: 60)
                .cornerRadius(10)

            
            VStack (alignment : .leading) {
                Text("D'où vient-il?")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Contrairement à une opinion répandue, le Lorem Ipsum n'est pas simplement du texte aléatoire. Il trouve ses racines dans une oeuvre de la littérature latine classique datant de 45 av. J.-C., le rendant vieux de 2000 ans.")
                    //.lineLimit(2)
                    .font(.system(size : 15))
                    .foregroundColor(.white)
                
                Divider() // 그림과 글자 비율을 맞추기 위해서/ // 그림 : 글글글글
                    .opacity(0)
            }
        }
        .padding()
        .frame(width : 300)
        .background(Color.green)
        .cornerRadius(20)
        //.padding(.bottom, 25)
    }
    
    func createTopSolidMessageView() -> some View {
        HStack (spacing : 10) {
            Image(systemName : "paperplane.circle.fill")
                .font(.system(size : 40))
                .foregroundColor(.white)
            VStack (alignment : .leading) {
                Text("Pourquoi l'utiliser?")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même.")
                    .lineLimit(2)
                    .font(.system(size : 15))
                    .foregroundColor(.white)
                
                Divider() // 그림과 글자 비율을 맞추기 위해서/ // 그림 : 글글글글
                    .opacity(0)
            }
        }
        .frame(width : UIScreen.main.bounds.width)
        .padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 20 : 35)
        .background(Color.blue)
    }

    func createTopToastMessageView() -> some View {
        HStack (alignment : .center, spacing : 10) {
            Image(systemName: "message")
                .font(.system(size : 40))
                .foregroundColor(.white)

            
            VStack (alignment : .leading, spacing : 10) {
                Text("Message")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Où puis-je m'en procurer?")
                    //.lineLimit(2)
                    .font(.system(size : 15))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.orange)
        .cornerRadius(30)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : 30)
    }

    func createPopUpMessageView() -> some View {
        VStack(spacing : 10) {
            Image(systemName: "terminal")
                .foregroundColor(.white)
                .font(.system(size : 100))
            
            Text("Bonjour, Gyurim!")
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Text("Du texte.' est qu'il possède une distribution de lettres plus ou moins normale, et en tout cas comparable avec celle du français standard. De nombreuses suites logicielles de mise en page ou éditeurs de sites Web ont fait du Lorem Ipsum leur faux texte par défaut, et une recherche pour 'Lorem Ipsum' vous conduira vers de nombreux sites qui n'en sont encore qu'à leur phase de construction")
                .font(.system(size : 15))
                .foregroundColor(Color(red : 0.9, green : 0.9, blue : 0.9))
                .multilineTextAlignment(.center)
            
            Spacer().frame(height : 10)
            
            Button(action: {
                self.shouldShowPopUpMessage = false
            }){
                Text("exit")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            .frame(width : 100, height: 40)
            .background(Color.white)
            .cornerRadius(20)
        }
        .padding(.horizontal, 10)
        .frame(width: 300, height: 500)
        .background(Color(hexcode: "8227b0"))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    
    var body: some View {
        ZStack {
            VStack {
                // Button 1
                Button(action: {
                    self.shouldShowBottomSolidMessage = true
                }, label: {
                    Text("Bottom Solid Message")
                        .foregroundColor(.white)
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                })
                
                // Button 2
                Button(action: {
                    self.shouldShowBottomToastMessage = true
                }, label: {
                    Text("Bottom Toast Message")
                        .foregroundColor(.white)
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                })
                
                // Button 3
                Button(action: {
                    self.shouldShowTopSolidMessage = true
                }, label: {
                    Text("Top Solid Message")
                        .foregroundColor(.white)
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                
                // Button 4
                Button(action: {
                    self.shouldShowTopToastMessage = true
                }, label: {
                    Text("Top Toast Message")
                        .foregroundColor(.white)
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                })
                
                // Button 5
                Button(action: {
                    self.shouldShowPopUpMessage = true
                }, label: {
                    Text("Pop-up")
                        .foregroundColor(.white)
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding()
                        .background(Color(hexcode :"8227b0"))
                        .cornerRadius(10)
                })
            } // VStack
        } // ZStack
        .edgesIgnoringSafeArea(.all)
        .popup(isPresented: $shouldShowBottomSolidMessage, type: .toast, position: .bottom, animation: .easeInOut, autohideIn: 2, closeOnTap: true, closeOnTapOutside: true) //, view: {
        {
            self.createBottomSolidMessageView()
        }
        .popup(isPresented: $shouldShowBottomToastMessage, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, closeOnTap: true, closeOnTapOutside: true, view: createBottomToastMessageView)
        .popup(isPresented: $shouldShowTopSolidMessage, type: .toast, position: .top, animation: .easeInOut, autohideIn: 2, closeOnTap: true, closeOnTapOutside: true, view: createTopSolidMessageView)
        .popup(isPresented: $shouldShowTopToastMessage, type: .floater(verticalPadding: 20), position: .top, animation: .spring(), autohideIn: 2, closeOnTap: true, closeOnTapOutside: true, view: createTopToastMessageView)
        .popup(isPresented: $shouldShowPopUpMessage, type: .default, position: .bottom, animation: .spring(), autohideIn: .none, closeOnTap: false, closeOnTapOutside: true, view: createPopUpMessageView)
    
    } // body View
}

//extension Color {
//
//}
