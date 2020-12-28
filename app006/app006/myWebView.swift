//
//  myWebView.swift
//  app006
//
//  Created by 박규림 on 2020/12/28.
//

import SwiftUI
import WebKit

struct myWebView : UIViewRepresentable {
    var urlToLoad : String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string : self.urlToLoad) else {
            return WKWebView()
        }
        
        let webview = WKWebView()
    
        webview.load(URLRequest(url : url))
    
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<myWebView>) {
        
    }
}
