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
            ZStack{
                Text("Add a new recipe 🥘")
                    .font(.title)
                    .bold()
                    .position(x: 200, y: 50)
                Text("Add a new recipe ")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color("Egg yellow"))
                    .position(x: 181, y: 50)
                Text("Recipe Name")
                    .font(.system(size: 15))
                    .position(x: 80, y: 100)
                TextField("Recipe Name", text: $recipe.name)
                    .keyboardType(.default)
                    .font(.system(size: 15))
                    .padding()
                    .frame(maxWidth: 350)
                    .background(
                        RoundedRectangle(cornerRadius: 30).fill(Color.white)
                            .stroke(Color("Dark Indigo"), lineWidth: recipe.id == nil ? 2 : 0)
                    )

                    .position(x: 200, y: 150)
                Text("Recipe Description")
                    .font(.system(size: 15))
                    .position(x: 95, y: 200)
                
                TextField("Recipe Description", text: $recipe.description)
                    .keyboardType(.default)
                    .font(.system(size: 15))
                    .padding()
                    .frame(maxWidth: 350)
                    .background (
                        RoundedRectangle(cornerRadius: 30).fill(Color.white)
                            .stroke(Color("Dark Indigo"), lineWidth: recipe.id == nil ? 2 : 0)
                    )
                    .position(x: 200, y: 250)

            }
            .disabled(recipe.id == nil ? false : true)
            
            RecipeDetailPhotosScrollView(photos: photos, recipe: recipe)
            
//            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
//                Image(systemName: "photo")
//                Text("Photo")
//            }
//            .onChange(of: selectedPhoto) { newValue in
//                Task {
//                    do {
//                        if let data = try await newValue?.loadTransferable(type: Data.self) {
//                            if let uiImage = UIImage(data: data) {
//                                uiImageSelected = uiImage
//                                print("W bozo, succussefully saved image")
//                                newPhoto = Photo()
//                                if recipe.id != nil {
//                                    showPhotoViewSheet.toggle()
//                                }
//                            }
//                        }
//                    } catch {
//                        print("rip bozo, selecting image failed")
//                    }
//                }
//            }
//            .buttonStyle(.borderedProminent)
//            .bold()
//            .tint(.blue)
//            .onAppear {
//                if recipe.id != nil {
//                    $photos.path = "recipes/\(recipe.id ?? "")/photos"
//                    print ("photos.path: \($photos.path)")
//                } else {
//                    print ("rip bozo, no id")
//                }
//            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(recipe.id == nil)
            .toolbar {
                if recipe.id == nil {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .bold()
                        .frame(width: 100, height: 30)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 30).fill(Color("Orange red"))
                        )
                        
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
                        .bold()
                        .frame(width: 100, height: 30)
                        .foregroundColor(Color("Dark Indigo"))
                        .background(
                            RoundedRectangle(cornerRadius: 30).fill(Color("Light baby blue"))
                        )
                    }
                }
            }
            .sheet(isPresented: $showPhotoViewSheet){
                NavigationStack {
                    PhotoView(photo: $newPhoto, uiImage: uiImageSelected, recipe: recipe)
                        .background(Color("Light egg yellow").edgesIgnoringSafeArea(.all))
                }
            }
            
        }
        .background(Color("Light egg yellow").edgesIgnoringSafeArea(.all))
    }
}

