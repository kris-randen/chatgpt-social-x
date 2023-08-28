//
//  ImagePicker.swift
//  socialX
//
//  Created by Krishnaswami Rajendren on 8/29/23.
//

import SwiftUI

struct ImagePicker: View {
    @Binding var image: Image?
    @State private var isImagePickerPresented = false

    var body: some View {
        Button("Select Image") {
            isImagePickerPresented.toggle()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePickerCoordinator(image: $image, isPresented: $isImagePickerPresented)
        }
    }
}

struct ImagePickerCoordinator: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerCoordinator

        init(_ parent: ImagePickerCoordinator) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: selectedImage)
            }
            parent.isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}
