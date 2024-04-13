//
//  AuthenticationService.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import Foundation
import FirebaseAuth
import Combine

class AuthenticationService: ObservableObject {
    static let shared = AuthenticationService()
    
    @Published var user: User? = Auth.auth().currentUser  // Initialize with the current user
    
    // Function to log in the user with email and password
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                // User logged in successfully
                user = result.user
                completion(.success(result.user))
            }
        }
    }
    
    // Function to sign up a new user with email and password
    func signup(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                // User signed up successfully
                completion(.success(result.user))
            }
        }
    }
    
    // Add the logout method:
    func logout() {
        do {
            try Auth.auth().signOut()
            print("Current user \(String(describing: user)) signed out")
            self.user = nil  // Set the user to nil after logging out
        } catch let error {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}
