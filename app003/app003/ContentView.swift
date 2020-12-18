//
//  ContentView.swift
//  app003
//
//  Created by 박규림 on 2020/12/18.
//

import SwiftUI

struct ContentView: View {
    
    static let dateFormat : DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        formatter.dateStyle = .full
        return formatter
    }()
    
    var today = Date()
    
    var trueOrFalse : Bool = false
    
    var number : Int = 123
    
    var body: some View {
        
        VStack{
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.")
                //.font(.headline)
                .tracking(2) // 글자와 글자사이 간격; 텍스트 바로 밑에 써야함
                .font(.system(.body, design : .rounded))
                .fontWeight(.medium)
                .multilineTextAlignment(.center) // 정렬 ; leading, center, trailing ; default -> leading
                .lineLimit(nil) // 줄 수 제한
                .lineSpacing(10) // 줄 간격
                .truncationMode(.middle) //글자수가 많을때 잘릴 부분 (맨 밑줄) ; head middle tail
                .shadow(color: Color.red, radius: 1.5, x: -10, y: 10) // 그림자 효과
                .padding(.vertical, 20)
                .background(Color.yellow)
                .foregroundColor(Color.black)
                .cornerRadius(20)
                .padding() // 중첩된 패딩!
                .background(Color.green)
                .cornerRadius(20)
                .padding()
            
            Text("안녕하세요!!")
                .background(Color.gray)
                .foregroundColor(.white)
            
            Text("오늘의 날짜 : \(today, formatter : ContentView.dateFormat)")
            
            Text("Boolean : \(String(trueOrFalse))")
            Text("number : \(number)")
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
