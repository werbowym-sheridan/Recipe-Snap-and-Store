//
//  PhotoView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI
import Firebase

struct PhotoView: View {
    @EnvironmentObject var recipeVM: RecipeViewModel
    @Binding var photo: Photo
    var uiImage: UIImage
    var recipe: Recipe
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                TextField("Description", text: $photo.description)
                    .textFieldStyle(.roundedBorder)
                    .disabled(!(Auth.auth().currentUser?.email == photo.poster))
                    .padding()
                
                Text("by: \(photo.poster) on \(photo.postedDate.formatted(date: .numeric, time: .omitted))")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding()
            .toolbar {
                if Auth.auth().currentUser?.email == photo.poster {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .automatic){
                        Button("Save"){
                            Task {
                                let success = await recipeVM.saveImage(recipe: recipe, photo: photo, image: uiImage)
                                if success {
                                    dismiss()
                                }
                            }
                        }
                    }
                } else {
                    ToolbarItem(placement: .automatic) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
                
            }
                
        }
    }
}
