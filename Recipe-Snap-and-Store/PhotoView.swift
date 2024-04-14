//
//  PhotoView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI

struct PhotoView: View {
    @EnvironmentObject var recipeVM: RecipeViewModel
    @State private var photo = Photo()
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
                
                Text("by: \(photo.poster) on \(photo.postedDate.formatted(date: .numeric, time: .omitted))")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding()
            .toolbar {
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
            }
                
        }
    }
}
