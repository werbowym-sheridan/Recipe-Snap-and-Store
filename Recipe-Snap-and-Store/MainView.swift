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
    
    // Define the colors based on the hex values provided
    let backgroundColor = Color(hex: "FFF0E0")
    let signOutButtonColor = Color(hex: "FFFEE0")
    let addButtonColor = Color(hex: "BBBBBB")
    let listItemColors = [Color(hex: "ACC0B6"), Color(hex: "EEC7C7"), Color(hex: "E9D2BD"), Color(hex: "839796")]
    
    let bottomImage = Image("eating-together")
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomLeading) {
                backgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    List {
                        ForEach(recipes.indices, id: \.self) { index in
                            let recipe = recipes[index]
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                Text(recipe.name)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 2)
                                    .fontWeight(.bold)
                                    .listRowInsets(EdgeInsets())
                                    .listRowSeparator(.hidden)
                                    .frame(maxWidth: .infinity, minHeight: 30, alignment: .leading)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .background(listItemColors[index % listItemColors.count])
                                    .cornerRadius(10)
                                    .offset(x: 30)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.black), lineWidth: 2.5)
                            )
                            .listStyle(PlainListStyle())
                            .background(listItemColors[index % listItemColors.count])
                            .listRowBackground(backgroundColor)
                            .listRowSeparator(.hidden)
                            .cornerRadius(10)
                            .shadow(radius: 5, y: 5)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .padding(.horizontal, 0)
                    .padding(.vertical, 20)
                    .background(backgroundColor)
                    .navigationTitle("Recipe Snaps")
                    .navigationBarItems(
                       leading: Button("Sign Out", action: {
                           do {
                               try authService.logout()
                               dismiss()
                           } catch {
                               print("Error signing out: \(error.localizedDescription)")
                           }
                       })
                       .buttonStyle(SignOutButtonStyle()),
                       trailing: Button(action: {
                           sheetIsPresented.toggle()
                       }) {
                           Image(systemName: "plus")
                               .resizable()
                               .frame(width: 22, height: 22)
                               .padding(10)
                               .background(Color(hex: "FFFEE0"))
                               .clipShape(Circle())
                               .shadow(radius: 5, y: 5)
                               .foregroundColor(Color(hex: "BBBBBB"))
                       }
                       .offset(x: -10, y: 0)
                   )
                   .navigationBarTitleDisplayMode(.inline)
                }
                
                VStack{
                    Spacer()
                    Line()
                        .padding()
                        .bold()
                        .foregroundColor(Color("Egg yellow"))
                        .offset(y: -30)
                    
                    // Bottom image
                    Image("eating-together")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200) // Set this height to the appropriate value
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: -40)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
                RecipeDetailView(recipe: Recipe())
            }
        }
    }
}

struct SignOutButton: View {
    var action: () -> Void
    var body: some View {
        Button("Sign Out", action: action)
            .buttonStyle(SignOutButtonStyle())
    }
}

struct PlusButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
        }
        .buttonStyle(PlusButtonStyle())
    }
}

struct SignOutButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding(.all, 10)
            .background(Color(hex: "FFFEE0"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.black), lineWidth: 1.5)
            )
            .fontWeight(.bold)
            .shadow(radius: 5, y: 5)
    }
}

struct PlusButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color(hex: "BBBBBB"))
            .padding()
            .background(Color(hex: "FFFEE0"))
            .clipShape(Circle())
            .shadow(radius: 5, y: 5)
    }
}


// Add an extension to convert hex colors to Color
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
