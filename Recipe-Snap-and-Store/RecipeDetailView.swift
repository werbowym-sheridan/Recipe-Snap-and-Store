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
    @State var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPhoto: PhotosPickerItem?
    
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
                                //TODO: this is where i set Image = Image(uiImage: uiImage) or call func to save image
                                print("W bozo, succussefully saved image")
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
                                dismiss()
                            } else {
                                print ("rip bozo, Failed to save recipe")
                            }
                        }
                        dismiss()
                    }
                }
            }
        }
    }
    
    struct RecipeDetailView_Previews: PreviewProvider {
        static var previews: some View {
            RecipeDetailView(recipe: Recipe())
        }
    }
}
