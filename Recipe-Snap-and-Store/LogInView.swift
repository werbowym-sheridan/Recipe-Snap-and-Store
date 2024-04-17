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
            ZStack{
                NavigationLink(destination: ContentView()) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                        .bold()
                        .frame(maxWidth: 270, maxHeight: 30)
                        .padding()
                        .cornerRadius(30)
                }
                .navigationBarBackButtonHidden(true)
                .position(x: 50, y: 50)
                Text("Welcome Back")
                    .font(.largeTitle)
                    .bold()
                    .position(x: 205, y: 102)
                Text("Welcome Back")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.orangeRed)
                    .position(x: 201, y: 100)
                
                Image(.signInPic)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .position(x: 200, y: 250)
                Text("Email")
                    .position(x: 60, y: 380)
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.lightGray, lineWidth:2)
                    )
                    .frame(width: 350)
                    .position(x: 195, y: 420)
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 10))
                        .position(x: 195, y: 570)
                }
                Text("Password")
                    .position(x: 75, y: 480)
                SecureField("Enter your password", text: $password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.lightGray, lineWidth:2)
                    )
                    .frame(width: 350)
                    .position(x: 195, y: 520)
                
                Button("Sign In") {
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
                .bold()
                .frame(maxWidth: 350, maxHeight: 60)
                .background(Color.eggYellow)
                .cornerRadius(30)
                .shadow(color: .gray, radius: 3, x: 2, y: 2)
                .position(x: 195, y: 640)

                NavigationLink(destination: MainView(), isActive: $isLoggedin) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
