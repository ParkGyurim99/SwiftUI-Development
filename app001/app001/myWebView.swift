//
//  myWebView.swift
//  app002
//
//  Created by 박규림 on 2020/12/17.
//

import SwiftUI
import WebKit

//uikit의 uiview를 사용할 수 있도록 한다.
//swiftui에서 uiviewcontroller를 쓰고 싶다 ? -> UIViewControllerRepresentable
struct myWebView : UIViewRepresentable {
    var urlToLoad : String
    
    // Ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string : self.urlToLoad) else {
            return WKWebView()
        }
        
        // 웹뷰 인스턴스 생성
        let webview = WKWebView()
        
        // 웹뷰를 로드함
        webview.load(URLRequest(url : url))
        
        return webview
    }
    
    
    // 업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<myWebView>) {
        
    }
}
