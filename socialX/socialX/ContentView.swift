//
//  ContentView.swift
//  socialX
//
//  Created by Krishnaswami Rajendren on 8/29/23.
//

import SwiftUI
import Foundation

struct Video {
    let title: String
    let duration: TimeInterval
    let url: URL // Assume the video URL
    
    func play() {
        // Implement video playback logic
        print("Playing video: \(title)")
    }
    
    func pause() {
        // Implement video pause logic
        print("Pausing video: \(title)")
    }
    
    func seek(to time: TimeInterval) {
        // Implement seeking logic
        print("Seeking video \(title) to \(time) seconds")
    }
}

struct ContentView: View {
    @State private var description = ""
    @State private var selectedImage: Image?
    @State private var selectedVideo: Video?
    @State private var selectedPlatforms: Set<SocialMediaPlatform> = []
    @State private var postType: PostType = .post
    @State private var selectedHighlight: String = ""
    @State private var isImagePickerPresented = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Post Details")) {
                    TextField("Description", text: $description)
                    
                    // Encapsulate ImagePicker within the Form
                    Button("Select Image") {
                        isImagePickerPresented.toggle()
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(image: $selectedImage)
                    }
                    
                    Section(header: Text("Social Media Platforms")) {
                        Toggle("Twitter", isOn: bindingForPlatform(.twitter))
                        Toggle("Instagram", isOn: bindingForPlatform(.instagram))
                        Toggle("LinkedIn", isOn: bindingForPlatform(.linkedin))
                    }
                    
                    Section(header: Text("Post Type")) {
                        Picker("Post Type", selection: $postType) {
                            ForEach(PostType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                    }
                    
                    if postType == .instagram {
                        Section(header: Text("Instagram Options")) {
                            TextField("Highlight", text: $selectedHighlight)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Create Post")
        .navigationBarItems(trailing: Button("Post", action: post))
        
        func bindingForPlatform(_ platform: SocialMediaPlatform) -> Binding<Bool> {
            Binding(
                get: {
                    selectedPlatforms.contains(platform)
                },
                set: { newValue in
                    if newValue {
                        selectedPlatforms.insert(platform)
                    } else {
                        selectedPlatforms.remove(platform)
                    }
                }
            )
        }

        func post() {
            // Call the PostManager to prepare and post the content
        }
    }
}

enum PostType: String, CaseIterable {
    case post = "Post"
    case story = "Story"
    case reel = "Reel"
}

enum SocialMediaPlatform: String, CaseIterable {
    case twitter = "Twitter"
    case instagram = "Instagram"
    case linkedin = "LinkedIn"
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
