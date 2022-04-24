//
//  File.swift
//  Fundamental Arithmetics
//
//  Created by Park Gyurim on 2022/04/24.
//

import Foundation

enum TextSet : String {
    case TitleText = "Fundamental Arithmetics"
    case OperationHintText = "Choose operation"
    case CardCountText = "Number of Cards"
    case StartButtonText = "Let's start!"
    
    case SuccessCaseAlert = "Good Job"
    case SuccessCaseMessage = "You did it!"
    case FailCaseAlert = "Please try again"
    case FailCaseMessage = "You can do it!"
    
    case Reset
    case Exit
    case Done
    
    case OK
    case Retry
}

enum GuideTextSet : String {
    case TitleText = "Guide : How to do❓"
    
    case Case1_Title = "📌 Drag to operate selected operation"
    case Case1_Description1 = "Drag one card over another card\nto do operation 🛠"
    case Case1_Description2 = "in left side"
    
    case Case2_Title = "📌 Drop to make target number"
    case Case2_Description1 = "Drop a card on left side to right side,\nMake target number to 0 ⚡️"
    case Case2_Description2 = "from left side to right side"
    
    case Case3 = "🔥 You don't always have to use every card\nto make the target number"
}

enum ImageNameSet : String {
    case selectedBox = "checkmark.square.fill"
    case unselectedBox = "square"
    case guidButton = "questionmark.circle.fill"
    case background
    
    case xmark
}
