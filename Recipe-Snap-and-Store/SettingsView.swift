//
//  SettingsView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var authService = AuthenticationService.shared
    
    var body: some View {
        Button("Log Out") {
            authService.logout()
//            presentationMode.wrappedValue.dismiss() // Dismiss SettingsView
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
