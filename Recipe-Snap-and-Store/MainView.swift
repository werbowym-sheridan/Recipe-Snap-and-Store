//
//  MainView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct MainView: View {
    @FirestoreQuery(collectionPath: "recipes") var recipes: [Recipe]
    @State private var sheetIsPresented = false
    @ObservedObject var authService = AuthenticationService.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(recipes) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    Text(recipe.name)
                        .font(.title2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Recipe Snaps")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        do {
                            try authService.logout()
                            print("signed out")
                            dismiss()
                        } catch {
                            print("rip bozo no sign out")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    RecipeDetailView(recipe: Recipe())
                }
            }
        }
    }
}
