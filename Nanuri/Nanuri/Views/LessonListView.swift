//
//  LessonListView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI
import SwiftUIPullToRefresh
import URLImage

struct LessonListView: View {
    @StateObject private var viewModel = LessonListViewModel()
    
    @Binding var locationButton : Bool
    @Binding var District : String
    @Binding var selectedTab : Int
    
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
                NavigationLink {
                    LessonCreateView()
                } label : {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
                Button {
                    withAnimation { viewModel.isSearching.toggle() }
                } label : {
                    Image(systemName : "magnifyingglass")
                        .foregroundColor(.black)
                }
            }.padding(.horizontal, 20)
            Divider().padding(.horizontal)
            
            if viewModel.isSearching {
                HStack {
                    TextField("검색", text : $viewModel.searchingText)
                        .padding(.vertical, 7)
                        .padding(.horizontal)
                        .background(Color.systemDefaultGray)
                        .cornerRadius(20)
                    Button {
                        withAnimation { viewModel.isSearching = false }
                        viewModel.searchingText = ""
                    } label : {
                        Text("취소")
                            .fontWeight(.semibold)
                    }
                }.padding(5)
                .padding(.horizontal, 10)
            }
            
            RefreshableScrollView(onRefresh : { done in
                viewModel.isFetchDone = false
                print("Fetch new post")
                viewModel.fetchLessons()
                withAnimation { viewModel.isSearching = false }
                viewModel.searchingText = ""
                hideKeyboard()
                done()
            }) {
                //ScrollViewReader { proxy in
//                if !viewModel.isFetchDone {
//                    VStack {
//                        Spacer()
//                        ProgressView()
//                        Spacer()
//                    }
//                }
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
                    ForEach(viewModel.LessonList.filter {
                        if !viewModel.searchingText.isEmpty {
                            return $0.lessonName.contains((viewModel.searchingText))
                        } else { return true }
                    }, id : \.self) { lesson in
                        Button {
                            viewModel.selectedLesson = lesson
                            viewModel.detailViewShow = true
                        } label : {
                            ZStack {
                                if !lesson.images.isEmpty {
                                URLImage(URL(string : lesson.images[0].lessonImgId.lessonImg)
                                         ?? URL(string: "https://static.thenounproject.com/png/741653-200.png")!
                                ) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }.frame(maxWidth : .infinity, maxHeight : .infinity)
                                    .overlay {
                                        LinearGradient(
                                            colors: [.black.opacity(0.01), .black.opacity(0.7)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }
                                } else {
                                    Color.blue
                                }
                                
                                VStack {
                                    HStack {
                                        Text(lesson.status ? "모집중" : "모집완료")
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(lesson.status ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
                                            .cornerRadius(20)
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text("#" + lesson.category)
                                    }
                                    HStack {
                                        Spacer()
                                        Text(lesson.lessonName)
                                            .font(.system(size: 45, weight : .semibold))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.4)
                                    }
                                    HStack {
                                        Spacer()
                                        Text(convertReturnedDateString(lesson.createDate))
                                            .foregroundColor(.white.opacity(0.8))
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
        .navigationTitle(Text(""))
        .fullScreenCover(isPresented: $viewModel.detailViewShow) { LessonInfoView(lesson : viewModel.selectedLesson) }
        .onAppear { viewModel.fetchLessons() }
        .onChange(of: District) { _ in
            //viewModel.selectedDistrict = District
            print("Fetch Lessons in " + District)
            viewModel.fetchLessons()
        }
    }
}
