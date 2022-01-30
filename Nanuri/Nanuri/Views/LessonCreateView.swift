//
//  LessonCreateView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/30.
//

import SwiftUI
import PhotosUI

struct LessonCreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = LessonCreateViewModel()
    
    var ImageArea : some View {
        VStack {
            Divider()
            HStack {
                Button {
                    viewModel.showImagePicker = true
                } label : {
                    VStack {
                        Image(systemName : "camera")
                                .font(.system(size : 22))
                        Text("\(viewModel.selectedImages.count)/4")
                    }.foregroundColor(.gray)
                    .frame(width : 65, height : 65)
                    .background(Color.systemDefaultGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                ForEach(viewModel.selectedImages.indices, id : \.self) { index in
                    Image(uiImage: viewModel.selectedImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width : 65, height : 65)
                        .cornerRadius(10)
                        .overlay(
                            Button {
                                withAnimation { _ = viewModel.selectedImages.remove(at: index) }
                            } label : {
                                Image(systemName: "xmark")
                                    .font(.system(size: 11))
                                    .padding(4)
                                    .background(Color.black)
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                                    .offset(x: 27, y: -27)
                            }
                        )
                }
            }.padding()
            .frame(maxWidth : .infinity, alignment : .leading)
            Divider().padding(.horizontal)
        }
    }
    
    var InputField : some View {
        VStack {
            TextField("클래스 이름", text : $viewModel.titleText)
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.95, height: 50)
            Divider().padding(.horizontal)
            TextField("카테고리", text : $viewModel.categoryText)
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.95, height: 50)
            Divider().padding(.horizontal)
            HStack {
                TextField("클래스 장소", text : $viewModel.locationText)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: 50)
                Spacer()
                TextField("제한인원", text : $viewModel.participantLimit)
                    .keyboardType(.decimalPad)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 50)
            }.frame(maxWidth: UIScreen.main.bounds.width * 0.95)
            Divider().padding(.horizontal)
            TextField("내용", text : $viewModel.contentText)
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.95, height: 50)
        }
    }
    
    var BottomToolbar : some View {
        VStack {
            Divider()
            HStack {
                Spacer()
                Button {
                    hideKeyboard()
                } label : {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .font(.system(size : 20))
                        .foregroundColor(.gray)
                }.padding(.vertical, 5)
                .padding(.horizontal)
            }
        }
    }
    
    var body: some View {
        VStack {
            ImageArea
            InputField
            Spacer()
            BottomToolbar
        }.navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("클래스 생성"))
        .navigationBarItems(
            trailing:
                Button {
                    // 생성 API 호출
                    viewModel.upload() // 모든 필드가 채워졌는지 조건 달거임
                    // 뒤로가기
                } label : {
                    Text("완료")
                }
        )
        .sheet(isPresented: $viewModel.showImagePicker) {
            PhotoPicker(
                configuration: viewModel.configuration,
                isPresented: $viewModel.showImagePicker,
                pickerResult: $viewModel.selectedImages)
                .edgesIgnoringSafeArea(.bottom)
        }.onChange(of: viewModel.isUploadDone) { _ in
            presentationMode.wrappedValue.dismiss()
        }.alert(isPresented: $viewModel.isUploadFail) {
            Alert(
                title: Text("클래스 생성 실패"),
                message: Text("클래스 생성 실패 메시지"),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

struct LessonCreateView_Previews: PreviewProvider {
    static var previews: some View {
        LessonCreateView()
    }
}
