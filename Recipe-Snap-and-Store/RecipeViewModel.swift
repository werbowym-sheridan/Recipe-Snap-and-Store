//
//  RecipeViewModel.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

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
    
    func saveImage(recipe: Recipe, photo: Photo, image: UIImage) async -> Bool {
        guard let recipeID = recipe.id else {
            print("rip bozo, recipe id is nil")
            return false
        }
        
        let photoName = UUID().uuidString //image file name
        let storage = Storage.storage() //create firebase storage instance
        let storageRef = storage.reference().child("\(recipeID)/\(photoName).jpeg")
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("rip bozo, could not resize image")
            return false
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        var imageURLString = "" //setting this after image saves properly
        
        do {
            let _ = try await storageRef.putDataAsync(resizedImage, metadata: metadata)
            print("succussefully uploaded image")
            do {
                let imageURL = try await storageRef.downloadURL()
                imageURLString = "\(imageURL)" //saving to cloud firestore as part of document in 'photos' collection
            } catch {
                print("rip bozo, failed to get download url after saving image")
                return false
            }
        } catch {
            print("rip bozo, failed to upload image to firebasestorage")
            return false
        }
        
        //saving to 'photos' collection of the recipe document 'recipeID"
        let db = Firestore.firestore()
        let collectionString = "recipes/\(recipeID)/photos"
        
        do { 
            var newPhoto = photo
            newPhoto.imageURLString = imageURLString
            try await db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("succussefully saved image")
            return true
        } catch {
            print("rip bozo, could not update data in 'photos' for recipeID \(recipeID)")
            return false
        }
    }
}
