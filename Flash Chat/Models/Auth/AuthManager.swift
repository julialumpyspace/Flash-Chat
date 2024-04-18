//
//  AuthManager.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import Foundation
import FirebaseAuth

class AuthManager: Observable {
    @Published var error: String
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.error = error?.localizedDescription ?? "Error occured during the request"
            } else {
                self.performSegue(withIdentifier: K.Segue_RegisterToChat_ID, sender: self)
            }
        }
    }
    
    func login() {
        
    }
    
    func logout() {
        
    }
}
