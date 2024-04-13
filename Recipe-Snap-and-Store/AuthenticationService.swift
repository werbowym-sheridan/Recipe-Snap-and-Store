//
//  AuthenticationService.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import Foundation
import FirebaseAuth

class AuthenticationService {
    static let shared = AuthenticationService()
    
    // Function to log in the user with email and password
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                // User logged in successfully
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
}
