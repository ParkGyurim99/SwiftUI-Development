//
//  ContentView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("District") var selectedDistrict = "지역 선택"
    
    @State var isLocationBtnClicked : Bool = false
    //@State var selectedDistrict : String = "District #1"
    @State var selectedTab : Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing : 0) {
                    TabView(selection : $selectedTab.animation(.spring())) {
                        LessonListView(locationButtonClicked: $isLocationBtnClicked,
                                      selectedDistrict: $selectedDistrict,
                                      selectedTab: $selectedTab)
                                        .tag(0)
                        
                        MyPageView().tag(1)
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay(
                        Color.black.opacity(isLocationBtnClicked ? 0.5 : 0)
                            .edgesIgnoringSafeArea(.vertical)
                            .onTapGesture {withAnimation { isLocationBtnClicked = false }}
                    )
                    
                    Color.blue
                        .frame(width : UIScreen.main.bounds.width * 0.5, height : 3)
                        .offset(x : selectedTab == 0 ? -UIScreen.main.bounds.width * 0.25
                                                     : UIScreen.main.bounds.width * 0.25)
                        
                    HStack {
                        Button {
                            withAnimation(.spring()) {selectedTab = 0}
                        } label : {
                            VStack(spacing : 10) {
                                Image(systemName: "list.dash")
                                    .font(.system(size: 20))
                                Text("클래스")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }
                        }.frame(width: UIScreen.main.bounds.width * 0.4,height: 50)
                        .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        
                        Button {
                            withAnimation(.spring()) {selectedTab = 1}
                        } label : {
                            VStack(spacing : 5) {
                                Image(systemName: "person.circle")
                                    .font(.system(size: 20))
                                Text("마이 페이지")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }
                        }.frame(width: UIScreen.main.bounds.width * 0.4,height: 50)
                        .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    }.padding(.top, 7)
                    .padding(.bottom, 25)
                }.edgesIgnoringSafeArea(.bottom)

                // Custom Half Modal Sheet
                if isLocationBtnClicked {
                    VStack {
                        HStack {
                            Text("지역 선택 (ㄱ-ㅎ) : ")
                                .font(.headline)
                            Text(selectedDistrict)
                                .fontWeight(.light)
                            Spacer()
                            Button {
                                withAnimation { isLocationBtnClicked = false }
                            } label : {
                                Text("✓ 완료")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                        }.padding(10)
                        Divider()
                        Picker("District", selection: $selectedDistrict) {
                            ForEach(districtList, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.wheel)
                    }.padding(.horizontal)
                    .frame(height : UIScreen.main.bounds.height * 0.35) // 뷰 사이즈
                    .background(Color.systemDefaultGray)
                    .cornerRadius(20)
                    .transition(.move(edge: .bottom))
                    .offset(y: UIScreen.main.bounds.width * 0.7) // 위에서 밀어낼 사이즈
                    .zIndex(3)
                }
            } // ZStack
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
