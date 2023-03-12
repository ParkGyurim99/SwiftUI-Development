//
//  ContentView.swift
//  CommentCard
//
//  Created by Park Gyurim on 2023/02/27.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    // MARK: Dummy Data
    
    let dummyUser: WriterInfo = WriterInfo(memberId: 0, username: "UserName", description: "", profileImage: "")

    var testRepliedComment_1: [Comment] = [
        Comment(commentId: 5, content: "TestRepliedComment_1-0", like: false, likeCount: 5, createdAt: "", modifiable: true),
        Comment(commentId: 6, content: "TestRepliedComment_1-1", like: true, likeCount: 5, createdAt: "", modifiable: false),
        Comment(commentId: 7, content: "TestRepliedComment_1-2", like: true, likeCount: 5, createdAt: "", modifiable: false),
        Comment(commentId: 8, content: "TestRepliedComment_1-3", like: false, likeCount: 5, createdAt: "", modifiable: false),
    ]
    
    var testRepliedComment_4: [Comment] = [
        Comment(commentId: 9, content: "TestRepliedComment_4-0", like: true, likeCount: 5, createdAt: "", modifiable: false),
        Comment(commentId: 10, content: "TestRepliedComment_4-1", like: false, likeCount: 5, createdAt: "", modifiable: true),
        Comment(commentId: 11, content: "TestRepliedComment_4-2", like: false, likeCount: 5, createdAt: "", modifiable: false)
        
    ]

    var testComment: [Comment] = [
        Comment(commentId: 0, content: "TestComment_0", like: true, likeCount: 0, createdAt: "", modifiable: true),
        Comment(commentId: 1, content: "TestComment_1", like: true, likeCount: 0, createdAt: "", modifiable: true),
        Comment(commentId: 2, content: "TestComment_2", like: true, likeCount: 1, createdAt: "", modifiable: false),
        Comment(commentId: 3, content: "TestComment_3", like: false, likeCount: 5, createdAt: "", modifiable: false),
        Comment(commentId: 4, content: "TestComment_4", like: false, likeCount: 0, createdAt: "", modifiable: false),
    ]
    
    init() {
        Array(0..<5).forEach { testComment[$0].member = dummyUser }
        Array(0..<4).forEach { testRepliedComment_1[$0].member = dummyUser }
        Array(0..<3).forEach { testRepliedComment_4[$0].member = dummyUser }
        
        testComment[1].comments = testRepliedComment_1
        testComment[4].comments = testRepliedComment_1
    }
    
    //
    
    var body: some View {
        ScrollView {
            
            // 전체를 `CommentView` 로 분리해서 커뮤니티, 칼럼 둘다에서 재사용해야겠다.
            // 인자로 postID 만 받고, 개별 뷰와 뷰 모델을 가지도록 !!
            
            VStack(spacing: 0) {
                // Title 까지 포함하는 범위
                Text("Comments")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(testComment, id: \.self) { comment in
                    // MARK: Original Comment
                    CommentCard(comment)
                    
                    
                    // MARK: Comment
                    Color.gray.frame(height: 2)
                    
                    // MARK: Replied Comments
                    if let repliedComment = comment.comments {
                        ForEach(repliedComment, id: \.self) { repliedComment in
                            CommentCard(repliedComment, replied: true)
                            
                            // 여기 다른 색상 디바이더가 들어가서 분리가 되면 좋을 듯 .. ?
                            Color.gray.frame(height: 2)
                        }
                    }
                }
            }
            
            // 여기까지
        }
    }
}

struct CommentCard: View {
    @State var showActionSheet: Bool = false
    
    var comment: Comment
    let isReplied: Bool
    
    init(_ comment: Comment, replied isReplied: Bool = false) {
        self.comment = comment
        self.isReplied = isReplied
    }
    
    var body: some View {
        // TODO: Font, Color 변경
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                // TODO: ProfileImage 로 교체 KFImage(comment.member.profileImage ...)
                Circle()
                    .fill(Color.gray)
                    .frame(width: 32)
                VStack(alignment: .leading, spacing: 2) {
                    Text(comment.member?.username ?? "")
                    Text("20m ago") // TODO: 실제 날짜로 변경 → `comment.createdAt.convertReturnedDateString()`
                        .foregroundColor(Color(uiColor: UIColor(red: 0.482, green: 0.482, blue: 0.482, alpha: 1)))
                }.font(.system(size: 14))
                Spacer()
                Button {
                    showActionSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(Angle(degrees: 90))
                        .foregroundColor(.gray)
                }
            }.padding(.vertical, 6)

            Text(comment.content)
                .font(.system(size: 16))

            HStack {
                HStack {
                    Button {
                        // TODO: Toggle `like` status and invoke api request
                    } label: {
                        Image(systemName: comment.like ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .foregroundColor(comment.like ? Color.yellow : Color.black)
                    }
                    Text("\(comment.likeCount)")
                }
                if let repliedComments = comment.comments {
                    Image(systemName: "ellipsis.message")
                    Text("\(repliedComments.count)")
                }
                Spacer()
            }.font(.system(size: 14))
        }.padding(.horizontal)
        .padding(.top, 12)
        .padding(.bottom, 18)
        .padding(.leading, isReplied ? 16 : 0) // 대댓글인 경우 리딩패딩
        .background(Color.gray.opacity(isReplied ? 0.5 : 0)) // TODO: Color.systemDefaultGray
        .actionSheet(isPresented: $showActionSheet) {
            return comment.modifiable
                ? ActionSheet(
                    title: Text("Options"),
                    message: nil,
                    buttons: [ .default(Text("Modify comment")) { },
                               .destructive(Text("Delete comment")) { },
                               .cancel() ])
                : ActionSheet(
                    title: Text("Options"),
                    message: nil,
                    // TODO: 아래 기능에서 만약 즉시 삭제 기능 들어가면 상위에서 커맨트리스트를 바인딩으로 가지고 와야할 듯
                    buttons: [ .default(Text("Report this comment")) { },
                               .destructive(Text("Block this user")) { },
                               .cancel() ])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
