//
//  RecipeDetailView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var recipeVM = RecipeViewModel()
    @State var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group{
                TextField("Recipe Name", text: $recipe.name)
                    .font(.title)
                TextField("Recipe Description", text: $recipe.description)
                    .font(.title2)
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            Spacer()
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
