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
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                TextField("Add an image description", text: $photo.description)
                    .disabled(!(Auth.auth().currentUser?.email == photo.poster))
                    .padding()
                    .frame(maxWidth: 350)
                    .background(
                        RoundedRectangle(cornerRadius: 30).fill(Color.white)
                            .stroke(Color("Dark Indigo"), lineWidth: recipe.id == nil ? 2 : 0)
                    )
                    .position(x: 180, y: 100)
                
                Text("Edited by: \(photo.poster) on \(photo.postedDate.formatted(date: .numeric, time: .omitted))")
                    .bold()
                    .lineLimit(1)
                    .position(x: 180, y: 5)
            }
            .padding()
            .background(Color("Light egg yellow").ignoresSafeArea(.all))
            .toolbar {
                if Auth.auth().currentUser?.email == photo.poster {
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
                    
                    ToolbarItem(placement: .automatic){
                        Button("Save"){
                            Task {
                                let success = await recipeVM.saveImage(recipe: recipe, photo: photo, image: uiImage)
                                if success {
                                    dismiss()
                                }
                            }
                        }
                        .bold()
                        .frame(width: 100, height: 30)
                        .foregroundColor(Color("Dark Indigo"))
                        .background(
                            RoundedRectangle(cornerRadius: 30).fill(Color("Light baby blue"))
                        )
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
