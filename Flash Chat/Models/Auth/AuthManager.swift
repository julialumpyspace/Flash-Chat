//
//  AuthManager.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var response: AuthResponse?
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            var errorRes: ErrorResponse? = nil
            if error != nil {
                let message = error?.localizedDescription ?? ErrorMessage.requestError()
                errorRes = ErrorResponse(error: true, message: message)
            }
            DispatchQueue.main.async {
                self.response = AuthResponse(error: errorRes, result: authResult)
            }
            
            //            if error != nil {
            //                self.error = error?.localizedDescription ?? "Error occured during the request"
            //            } else {
            //                self.performSegue(withIdentifier: K.Segue_RegisterToChat_ID, sender: self)
            //            }
        }
    }
    
    func login() {
        
    }
    
    func logout() {
        
    }
}
