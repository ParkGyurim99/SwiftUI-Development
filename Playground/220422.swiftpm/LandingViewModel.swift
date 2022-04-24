//
//  LandingViewModel.swift
//  Fundamental Arithmetics
//
//  Created by Park Gyurim on 2022/04/23.
//

import Foundation

final class LandingViewModel : ObservableObject {
    @Published var selectedType : OperationType = .Plus
    @Published var showGuide : Bool = false
    @Published var selectedNumberOfCard : Int = 2
    @Published var showWheel : Bool  = false
    @Published var onGame : Bool = false   
}
