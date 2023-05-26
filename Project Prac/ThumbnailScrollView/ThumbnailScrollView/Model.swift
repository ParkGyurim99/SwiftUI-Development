//
//  Models.swift
//  ThumbnailScrollView
//
//  Created by Park Gyurim on 2023/05/23.
//

import SwiftUI

struct ContentsModel {
    let thumbnail: Image
    let title: String
    let date: String
    let subTitle: String
    let description: String
    
    static let dummy = ContentsModel(
        thumbnail: Image("SampleImage1"),
        title: "Lorem Ipsum",
        date: "Jan 1st, 2022",
        subTitle: "What is Lorem Ipsum?",
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    )
}
