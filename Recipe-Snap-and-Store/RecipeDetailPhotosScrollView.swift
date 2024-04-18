//
//  RecipeDetailPhotosScrollView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI

struct RecipeDetailPhotosScrollView: View {
//    struct FakePhoto: Identifiable {
//        let id = UUID().uuidString
//        var imageURLString = "https://firebasestorage.googleapis.com:443/v0/b/recipe-snap-and-store-64bb9.appspot.com/o/4WIOds1hLisAhfpgdXe5%2F8524D70C-6035-4C8F-ADAE-EDA076CA7E5C.jpeg?alt=media&token=5899b7e0-3f39-454d-9e44-0525b537cdeb"
//    }
//    let photos = [FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto()]
    
    @State private var showPhotoViewerView = false
    @State private var uiImage = UIImage()
    @State var selectedPhoto = Photo()
    var photos: [Photo]
    var recipe: Recipe
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack (spacing: 4) {
                ForEach(photos) { photo in
                    let imageURL = URL(string: photo.imageURLString) ?? URL(string: "")
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()
                            .cornerRadius(10)
                            .onTapGesture {
                                let renderer = ImageRenderer(content: image)
                                selectedPhoto = photo
                                uiImage = renderer.uiImage ?? UIImage()
                                showPhotoViewerView.toggle()
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                }
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 4)
        .sheet(isPresented: $showPhotoViewerView) {
            PhotoView(photo: $selectedPhoto, uiImage: uiImage, recipe: recipe)
        }
        .position(x:220, y: 100)
    }
}
