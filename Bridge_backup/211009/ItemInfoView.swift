//
//  SwiftUIView.swift
//  Bridge-iOS
//
//  Created by Park Gyurim on 2021/10/05.
//

import SwiftUI
import URLImage

struct ItemInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel : ItemInfoViewModel
    
    init(viewModel : ItemInfoViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            // Image Area
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(viewModel.itemInfo?.usedPostDetail.postImages ?? [], id : \.self) { imageInfo in
                            URLImage(
                                URL(string : imageInfo.image) ??
                                URL(string: "https://static.thenounproject.com/png/741653-200.png")!
                            ) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .frame(width : UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35)
                        }
                    }
                }
                Spacer()
            }.blur(radius: viewModel.isMemberInfoClicked ? 5 : 0)
            .onTapGesture {
                viewModel.isImageTap.toggle() // 이미지 확대 보기 기능
            }
            
            // Text Area
            VStack {
                Spacer()
                VStack(alignment : .leading) {
                    // Title
                    HStack {
                        VStack(alignment : .leading, spacing: 10) {
                            Text(viewModel.itemInfo?.usedPostDetail.title ?? "Title not found")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            HStack{
                                Text("time")
                                Text("| \((viewModel.itemInfo?.usedPostDetail.viewCount)!) View")
                                Text("| \((viewModel.itemInfo?.usedPostDetail.likeCount)!) Likes")
                            }.font(.system(size : 13))
                        }
                        Spacer()
                        Text("$ " + String(format: "%.1f", (viewModel.itemInfo?.usedPostDetail.price)!))
                            .font(.largeTitle)
                    }
                    
                    // User Area
                    HStack {
                        URLImage(URL(string: viewModel.itemInfo?.member.profileImage ?? "")!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(15)
                        
                        VStack(alignment : .leading, spacing: 5) {
                            Text((viewModel.itemInfo?.member.username)!).fontWeight(.semibold)
                            Text((viewModel.itemInfo?.member.description)!)
                        }
                        Spacer()
                        Button {
                            withAnimation { viewModel.isMemberInfoClicked = true }
                        } label : {
                            Image(systemName: "info.circle")
                                .font(.system(size: 20))
                                .padding(8)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .padding(.trailing, 5)
                        }
                    }
                    .padding(5)
                    .background(Color.systemDefaultGray)
                    .cornerRadius(15)
                    .shadow(radius: 1)
                    .padding(.bottom, 10)
                    
                    // Camp Info
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(viewModel.itemInfo?.usedPostDetail.camps ?? [], id : \.self) { camp in
                                Text(camp)
                                    .foregroundColor(.mainTheme)
                                    .font(.system(size : 12, weight : .semibold))
                                    .padding(6)
                                    .background(Color.systemDefaultGray)
                                    .cornerRadius(10)
                                    .shadow(radius: 1)
                                    .padding(.leading, 2)
                            }
                        }.frame(height : 30)
                    }

                    Divider()
                    
                    // Item Desc.
                    VStack(alignment : .leading, spacing: 10) {
                        HStack {
                        Text("About Item")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.mainTheme)
                            Spacer()
                            //if viewModel.itemInfo?.member.memberId =
                            Button {
                                // 수정 삭제 API
                                viewModel.showAction = true
                            } label : {
                                Image(systemName : "ellipsis")
                                    .foregroundColor(.black)
                                    .font(.system(size : 15, weight : .bold))
                            }
                        }
                        Text(viewModel.itemInfo?.usedPostDetail.description ?? "error")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button { } label : {
                            HStack {
                                Text("Knock Now!")
                                    .font(.system(size : 20, weight : .bold))
                                Image(systemName : "hand.wave.fill")
                                    .font(.system(size : 20, weight : .bold))
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.07)
                            .background(Color.mainTheme)
                            .cornerRadius(25)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .frame(width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.58)
                .background(Color.systemDefaultGray)
                .cornerRadius(25)
            }
            .edgesIgnoringSafeArea(.bottom)
            .shadow(radius: 5)
            .blur(radius: viewModel.isMemberInfoClicked ? 5 : 0)
            
            
            // Seller Information
            if viewModel.isMemberInfoClicked {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation { viewModel.isMemberInfoClicked = false }
                        } label : {
                            Image(systemName: "xmark.circle")
                                .font(.system(size : 20, weight : .bold))
                        }.padding()
                    }.frame(height: 50)
                    
                    URLImage(
                        URL(string : viewModel.itemInfo?.member.profileImage ?? "https://static.thenounproject.com/png/741653-200.png")!
                    ) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .clipShape(Circle())
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                    .shadow(radius: 5)
                    
                    Text(viewModel.itemInfo?.member.username ?? "Unknown UserName")
                        .font(.system(size : 20, weight : .bold))
                        .foregroundColor(.white)
                    Text("\"" + (viewModel.itemInfo?.member.description  ?? "User not found") + "\"")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(width : UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 1/3)
                .background(Color.mainTheme)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading : Button {
            self.presentationMode.wrappedValue.dismiss()
        } label : {
            Image(systemName : "chevron.backward")
                .foregroundColor(.mainTheme)
                .font(.system(size : 15, weight : .bold))
        }, trailing: Button {
            viewModel.isLiked?.toggle()
            viewModel.likePost(isliked: (viewModel.itemInfo?.usedPostDetail.like ?? true))
        } label: {
            //Image(systemName: (viewModel.itemInfo?.usedPostDetail.like ?? true) ? "heart.fill" : "heart")
            Image(systemName: (viewModel.isLiked ?? true) ? "heart.fill" : "heart")
                .font(.system(size : 15, weight : .bold))
                .foregroundColor(.black)
        })
        .actionSheet(isPresented: $viewModel.showAction) {
            ActionSheet(
                title: Text("Post Options"),
                buttons: [
                    .default(Text("Modify Post")) { viewModel.showPostModify = true },
                    .destructive(Text("Delete Post")) { viewModel.showConfirmDeletion = true },
                    .cancel()
                ]
            )
        }
        .alert(isPresented: $viewModel.showConfirmDeletion) {
            Alert(
                title: Text("Confirmation"),
                message: Text("Do you want to delete this item?"),
                primaryButton: .destructive(Text("Yes"), action : {
                    viewModel.deletePost()
                    self.presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel(Text("No")))
        }
        .background(
            NavigationLink(
                destination : VStack {Text(viewModel.token) }.navigationBarTitle(Text("Modify used-Post")),
                isActive : $viewModel.showPostModify) { }
        )
    }
}
