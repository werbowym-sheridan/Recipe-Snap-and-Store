//
//  RecipeDetailView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI
import FirebaseFirestoreSwift
import PhotosUI

struct RecipeDetailView: View {
    @ObservedObject var recipeVM = RecipeViewModel()
    @FirestoreQuery(collectionPath: "recipes") var photos: [Photo]
    @State var recipe: Recipe
    @State var newPhoto = Photo()
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var uiImageSelected = UIImage()
    @State private var showPhotoViewSheet = false
    
    var body: some View {
        VStack {
            Group{
                TextField("Recipe Name", text: $recipe.name)
                    .font(.title)
                TextField("Recipe Description", text: $recipe.description)
                    .font(.title2)
            }
            .disabled(recipe.id == nil ? false : true)
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: recipe.id == nil ? 2 : 0)
            }
            .padding(.horizontal)
            
            RecipeDetailPhotosScrollView(photos: photos, recipe: recipe)
            
            Spacer()
            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
                Image(systemName: "photo")
                Text("Photo")
            }
            .onChange(of: selectedPhoto) { newValue in
                Task {
                    do {
                        if let data = try await newValue?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                uiImageSelected = uiImage
                                print("W bozo, succussefully saved image")
                                newPhoto = Photo()
                                if recipe.id != nil {
                                    showPhotoViewSheet.toggle()
                                }
                            }
                        }
                    } catch {
                        print("rip bozo, selecting image failed")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .bold()
            .tint(.blue)
            .onAppear {
                if recipe.id != nil {
                    $photos.path = "recipes/\(recipe.id ?? "")/photos"
                    print ("photos.path: \($photos.path)")
                } else {
                    print ("rip bozo, no id")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(recipe.id == nil)
            .toolbar {
                if recipe.id == nil {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            Task {
                                let success = await recipeVM.saveRecipe(recipe: recipe)
                                if success {
                                    $photos.path = "recipes/\(recipe.id ?? "")/photos"
                                    showPhotoViewSheet.toggle()
                                } else {
                                    print ("rip bozo, Failed to save recipe")
                                }
                            }
                            dismiss()
                        }
                    }
                }
            }
            .sheet(isPresented: $showPhotoViewSheet){
                NavigationStack {
                    PhotoView(photo: $newPhoto, uiImage: uiImageSelected, recipe: recipe)
                }
            }
        }
        
    }
}
