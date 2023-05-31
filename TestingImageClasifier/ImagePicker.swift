//
//  ImagePicker.swift
//  TestingImageClasifier
//
//  Created by roba on 29/05/2023.
//


import SwiftUI
import UIKit
import PhotosUI

struct imagePicker: UIViewControllerRepresentable {
    @Binding var image: Optional<UIImage>
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configoration = PHPickerConfiguration()
        configoration.selectionLimit = 1
        configoration.filter = .images
        let picker = PHPickerViewController(configuration: configoration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: imagePicker
        
        init(_ parent: imagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]){
            picker.dismiss(animated: true)
            
            guard let item = results.first?.itemProvider else {
                return
            }
            
            guard item.canLoadObject(ofClass: UIImage.self) else {
               return
            }
            
            item.loadObject(ofClass: UIImage.self) {[self] orignalImage, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let uiImage =  orignalImage as? UIImage else {
                    return
                }
                parent.image = uiImage
            }
        }
    }
}
