//
//  LogInView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isLoggedin = false

    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Log In") {
                AuthenticationService.shared.login(email: email, password: password) { result in
                    switch result {
                    case .success(_):
                        self.isLoggedin = true
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
            
            NavigationLink(destination: MainView(), isActive: $isLoggedin) {
                EmptyView()
            }
        }
        .navigationTitle("Log In")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
