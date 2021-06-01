//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Park Gyurim on 2021/04/30.
//

import Foundation

struct EmojiArt {
    var backgroundURL : URL?
    var emojis = [Emoji]()
    
    struct Emoji : Identifiable {
        let text : String
        var x : Int // offset from center
        var y : Int // offset from center
        var size : Int
        let id : Int
        
        fileprivate init(text : String, x : Int, y : Int, size : Int, id : Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text : String, x : Int, y : Int, size : Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
    }
}
