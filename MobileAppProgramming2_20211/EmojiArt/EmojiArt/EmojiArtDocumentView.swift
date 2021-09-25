//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Park Gyurim on 2021/04/29.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document : EmojiArtDocument
    
    var body: some View {
        VStack {
            ScrollView (.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map{ String($0) }, id : \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size : self.defaultEmojiSize))
                            .onDrag{
                                NSItemProvider(object: emoji as NSString)
                            }
                    } // ForEach
                } // HStack
            }.padding(.horizontal)
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        Group {
                            if self.document.backgroundImage != nil {
                                Image(uiImage: self.document.backgroundImage!)
                            }
                        }
                    )
                    .edgesIgnoringSafeArea([.horizontal, .bottom])
                    .onDrop(of : ["public.image"], isTargeted: nil) { providers, location in
                        var location = geometry.convert(location, from : .global)
                        location = CGPoint(x : location.x - geometry.size.width / 2, y : location.y - geometry.size.height / 2)
                        return self.drop(providers : providers, at : location)
                    }
                    
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(self.font(for : emoji))
                            .position(self.position(for : emoji, in : geometry.size))
                    }
                }
            }
        }
    } // body
    private let defaultEmojiSize :CGFloat = 40
    
    private func drop(providers : [NSItemProvider], at location : CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            print("dropped \(url)")
            self.document.setBackgroundURL(url)
        }
        if !found {
            found = providers.loadObjects(ofType : String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        
        return found
    }
    
    private func font(for emoji : EmojiArt.Emoji) -> Font {
        Font.system(size: emoji.fontSize)
    }
    private func position(for emoji : EmojiArt.Emoji, in size : CGSize) -> CGPoint {
        CGPoint(x : emoji.location.x + size.width / 2, y : emoji.location.y + size.height / 2)
    }
} // View

//extension String : Identifiable {
//    public var id : String {
//        return self
//    }
//}
