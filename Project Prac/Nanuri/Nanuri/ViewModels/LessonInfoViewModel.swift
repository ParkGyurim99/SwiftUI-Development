//
//  LessonInfoViewModel.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/02/01.
//

import SwiftUI
import Alamofire

final class LessonInfoViewModel : ObservableObject {
    @Published var seeMore : Bool = false
    @Published var viewOffset : CGFloat = 0
    @Published var isImageTap : Bool = false
    @Published var showDeleteConfirmationMessage : Bool = false
    
    func updateLessonStatus(_ lessonId : Int) {
        let url = "http://ec2-3-39-19-215.ap-northeast-2.compute.amazonaws.com:8080/lesson/\(lessonId)/updateStatus"
        AF.request(url, method : .put)
            .responseJSON { response in print(response) }
    }
    
    func deleteLesson(_ lessonId : Int) {
        let url = "http://ec2-3-39-19-215.ap-northeast-2.compute.amazonaws.com:8080/lesson/\(lessonId)"
        AF.request(url, method : .delete)
            .responseJSON { response in print(response) }
    }
}
