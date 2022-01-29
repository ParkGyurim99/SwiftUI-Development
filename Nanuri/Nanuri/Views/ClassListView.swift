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
                            .fontWeight(.semibold)
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
                    Button {
                        
                    } label : {
                        HStack(spacing : 3) {
                            Spacer()
                            Image(systemName : "arrow.up.arrow.down")
                            Text("정렬").fontWeight(.semibold)
                        }.foregroundColor(.black)
                        .font(.system(size : 11))
                        .padding(.horizontal)
                    }
                    ForEach(0..<20, id : \.self) { i in
                        NavigationLink(destination: ClassInfoView()) {
                            ZStack {
                                Image("testImg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .overlay {
                                        //Color.black.opacity(0.3)
                                        LinearGradient(
                                            colors: [.black.opacity(0.01), .black.opacity(0.7)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }
                                
                                VStack {
                                    HStack {
                                        Text(i % 2 == 0 ? "모집완료" : "모집중")
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(i % 2 == 0 ? Color.red.opacity(0.7) : Color.green.opacity(0.7))
                                            .cornerRadius(20)
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text("[Class Description]")
                                    }
                                    HStack {
                                        Spacer()
                                        Text("[Class #\(i)]")
                                            .font(.system(size: 45, weight : .semibold))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.4)
                                    }
                                }.foregroundColor(.white)
                                .frame(width :UIScreen.main.bounds.width * 0.85, height : UIScreen.main.bounds.height * 0.26)
                            }.frame(width: UIScreen.main.bounds.width * 0.95, height : UIScreen.main.bounds.height * 0.3)
                            .cornerRadius(20)
                            .padding(5)
                        }
                    }
                }
                //}
            }
        }.padding(.top)
        .navigationBarHidden(true)
    }
}
