//
//  ThumbnailScrollView.swift
//  ThumbnailScrollView
//
//  Created by Park Gyurim on 2023/05/23.
//

import SwiftUI

struct ThumbnailScrollView {

    // MARK: `Thumbnail Size`
    enum ThumbnailSize {
        case small
        case medium
        case large
        case custom(size: CGFloat)
        
        private var rawValue: CGFloat {
            switch self {
            case .small: return 0.25
            case .medium: return 0.4
            case .large: return 0.55
            case .custom(let size): return size
            }
        }
        
        var width: CGFloat { UIScreen.main.bounds.width }
        var height: CGFloat { UIScreen.main.bounds.height * self.rawValue }
    }
    
}
