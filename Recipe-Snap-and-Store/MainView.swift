//
//  MainView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var authService = AuthenticationService.shared
    
    var body: some View {
        NavigationView {
            Text("Welcome to Recipe Snap & Store!")
                .navigationTitle("Home")
                .toolbar {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
        }
    }
}

#Preview {
    MainView()
}
