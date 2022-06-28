//
//  ImagePicker.swift
//  PortingUIKitVC
//
//  Created by Park Gyurim on 2022/06/28.
//

import PhotosUI
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .pageSheet
        
                if let popover = imagePicker.popoverPresentationController {
            let sheet = popover.adaptiveSheetPresentationController
            sheet.detents = [.medium() ] //, .large()]
//            sheet.largestUndimmedDetentIdentifier = .medium
//            sheet.prefersScrollingExpandsWhenScrolledToEdge =
//            PresentationHelper.sharedInstance.prefersScrollingExpandsWhenScrolledToEdge
//            sheet.prefersEdgeAttachedInCompactHeight =
//            PresentationHelper.sharedInstance.prefersEdgeAttachedInCompactHeight
//            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached =
//            PresentationHelper.sharedInstance.widthFollowsPreferredContentSizeWhenEdgeAttached
        }
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
