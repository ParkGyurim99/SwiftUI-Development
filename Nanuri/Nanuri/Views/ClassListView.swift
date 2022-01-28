//
//  ClassListView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI
import SwiftUIPullToRefresh

struct ClassListView: View {
    @Binding var locationButton : Bool
    @Binding var District : String
    @Binding var selectedTab : Int
    
    @State var isSearching : Bool = false
    @State var searchingText : String = ""
    
    init(locationButtonClicked : Binding<Bool>, selectedDistrict : Binding<String>, selectedTab : Binding<Int>) {
        _locationButton = locationButtonClicked
        _District = selectedDistrict
        _selectedTab = selectedTab
    }
    
    var body: some View {
        VStack {
            // Toolbar
            HStack(spacing : 10) {
                Button {
                    withAnimation(.spring()) {
                        locationButton.toggle()
                    }
                } label : {
                    Text(District + " ▾")
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                Spacer()
                Button {
                    withAnimation { isSearching.toggle() }
                } label : {
                    Image(systemName : "magnifyingglass")
                        .foregroundColor(.black)
                }
                Button {
                    
                } label : {
                    Image(systemName : "ellipsis")
                        .foregroundColor(.black)
                }
            }.padding(.horizontal, 20)
            Divider().padding(.horizontal)
            
            if isSearching {
                HStack {
                    TextField("검색", text : $searchingText)
                        .padding(.vertical, 7)
                        .padding(.horizontal)
                        .background(Color.systemDefaultGray)
                        .cornerRadius(20)
                    Button {
                        withAnimation { isSearching = false }
                        searchingText = ""
                    } label : {
                        Text("취소")
                    }
                }.padding(5)
                .padding(.horizontal, 10)
            }
            
            RefreshableScrollView(onRefresh : { done in
                print("Fetch new post")
                withAnimation { isSearching = false }
                searchingText = ""
                hideKeyboard()
                done()
            }) {
                //ScrollViewReader { proxy in
                LazyVStack {
                    ForEach(0..<20, id : \.self) { i in
                        NavigationLink(destination: ClassInfoView()) {
                            HStack {
                                Color.systemDefaultGray.frame(width: 100, height: 80)
                                
                                VStack(alignment : .leading, spacing : 10) {
                                    Text("Class #\(i)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
//                                    추가 기능 : 당근 마켓처럼 인근 동네까지 볼 수 있게
//                                    Text("[##동]")
//                                        .foregroundColor(.gray)
//                                        .font(.caption)
                                    
                                    Text("Class Description")
                                }.foregroundColor(.black)
                                Spacer()
                            }.frame(width: UIScreen.main.bounds.width * 0.9)
                        }
                        Color.systemDefaultGray
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 2)
                    }
                }
                //}
            }
        }.padding(.top)
        .navigationBarHidden(true)
    }
}
