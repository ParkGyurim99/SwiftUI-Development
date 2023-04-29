//
//  Dependencies.swift
//  Config
//
//  Created by Park Gyurim on 2023/04/28.
//

import ProjectDescription

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: [
        .remote(url: "https://github.com/onevcat/Kingfisher.git",
                requirement: .exact("7.6.2"))
    ],
    platforms: [.iOS]
)
