//
//  ImagePicker.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-07.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageURL: URL?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        var imageUploadManager = ImageUploadManager()

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func uploadImage(data: Data) async {
            do {
                let response = try await imageUploadManager.uploadImage(data: data)
                
                parent.imageURL = URL(string: response.data.url)
            } catch {
                print(error)
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage, let data = uiImage.pngData() {
                Task {
                    await uploadImage(data: data)
                    parent.presentationMode.wrappedValue.dismiss()
                }
            } else {
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
