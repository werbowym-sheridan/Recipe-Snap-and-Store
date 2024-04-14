//
//  RecipeViewModel.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import Foundation
import FirebaseFirestore

class RecipeViewModel: ObservableObject {
    @Published var recipes = Recipe()
    
    func saveRecipe(recipe: Recipe) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = recipe.id {
            do {
                try await db.collection("recipes").document(id).setData(recipe.dictionary)
                print("Recipe saved successfully")
                return true
            } catch {
                print("ERROR: rip bozo failed to update data .\(error.localizedDescription)")
                return false
            }
        } else {
            do {
                try await db.collection("recipes").addDocument(data: recipe.dictionary)
                return true
            } catch {
                print("ERROR: rip bozo could not create new recipe .\(error.localizedDescription)")
                return false
            }
        }
    }
}
