//
//  ContentView.swift
//  UIViewRepresentableTest
//
//  Created by Park Gyurim on 2023/03/09.
//

import SwiftUI

struct ContentView: View {
    let text: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text("What is Lorem Ipsum?")
                    .font(.custom("OpenSans-Bold", size: 22))
                
                Divider()
                
                SelectableTextView(text)
                    .padding()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SelectableTextView: View {
    @State private var viewHeight: CGFloat = .zero
    
    private let text: String
    private let fontSize: CGFloat
    private let fontWeight: Font.Weight
    private let textColor: Color
    private let tintColor: Color
    private let maxLineLimit: Int
    
    var fontName: String {
        switch fontWeight {
            case .ultraLight, .light, .thin: return "OpenSans-Light"
            case .regular: return "OpenSans-Regular"
            case .medium: return "OpenSans-Medium"
            case .semibold: return "OpenSans-SemiBold"
            case .bold: return "OpenSans-Bold"
            case .heavy, .black: return "OpenSans-ExtraBold"
            default: return "OpenSans-Regular"
        }
    }
    
    init(_ text: String,
         fontSize: CGFloat = 16,
         fontWeight: Font.Weight = .regular,
         textColor: Color = .black,
         tintColor: Color = .yellow,
         maxLineLimit: Int = Int.max
    ) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.textColor = textColor
        self.tintColor = tintColor
        self.maxLineLimit = maxLineLimit
    }
    
    var body: some View {
        SelectableUITextView(text: text,
                             viewHeight: $viewHeight,
                             fontName: fontName,
                             fontSize: fontSize,
                             textColor: textColor,
                             tintColor: tintColor,
                             maxLineLimit: maxLineLimit)
            .frame(height: viewHeight)
    }
    
    struct SelectableUITextView: UIViewRepresentable {
        let text: String
        @Binding var viewHeight: CGFloat
        let fontName: String
        let fontSize: CGFloat
        let textColor: Color
        let tintColor: Color
        let maxLineLimit: Int
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            
            textView.text = text
            textView.isEditable = false
            textView.font = UIFont.init(name: fontName, size: fontSize)
            textView.textColor = UIColor(textColor)
            textView.backgroundColor = .clear
            textView.tintColor = UIColor(tintColor)
            textView.textContainer.maximumNumberOfLines = maxLineLimit
            textView.textContainerInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
            
            DispatchQueue.main.async { viewHeight = textView.contentSize.height }
            
            return textView
        }
        
        func updateUIView(_ uiView: UITextView, context: Context) { }
    }
}
