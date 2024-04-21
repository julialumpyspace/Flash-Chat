//
//  AuthManager.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    private lazy var observers: [WeakAuthObserver] = []
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            var errorResponse: ErrorResponse = ErrorResponse(error: false, message: "")
            if let e = error {
                errorResponse = ErrorResponse(
                    error: true,
                    message: ErrorMessage.Auth.registration(error: e.localizedDescription))
            }
            let response = AuthResponse(error: errorResponse, result: authResult)
                self.notifyRegistrationDidFinish(response: response)
        }
    }
    
    func login(email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            var errorResponse: ErrorResponse = ErrorResponse(error: false, message: "")
            if let e = error {
                errorResponse = ErrorResponse(
                    error: true,
                    message: ErrorMessage.Auth.login(error: e.localizedDescription))
            }
            let response = AuthResponse(error: errorResponse, result: authResult)
                self.notifyLoggingInDidFinish(response: response)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            let errorResponse = ErrorResponse(error: false, message: "")
            let response = AuthResponse(error: errorResponse, result: nil)
                self.notifyLoggingOutDidFinish(response: response)
            
        } catch let error as NSError {
            let errorResponse = ErrorResponse(
                error: true,
                message: ErrorMessage.Auth.logout(error: error))
            let response = AuthResponse(error: errorResponse, result: nil)
                self.notifyLoggingOutDidFinish(response: response)
        }
    }
    
    func getAuthorizedUser() -> String? {
        return Auth.auth().currentUser?.email
    }
}


// MARK: - AuthObserver

extension AuthManager {
    func addObserver(_ observer: AuthObserver) {
        observers.append(WeakAuthObserver(value: observer))
    }
    
    func removeObserver(_ observer: AuthObserver) {
        observers.removeAll(where: { $0.value === observer })
    }
    
    func notifyRegistrationDidFinish(response: AuthResponse) {
        observers.forEach { $0.value?.registrationDidFinish(response: response)}
    }
    
    func notifyLoggingInDidFinish(response: AuthResponse) {
        observers.forEach { $0.value?.loginDidFinish(response: response)}
    }
    
    func notifyLoggingOutDidFinish(response: AuthResponse) {
        observers.forEach { $0.value?.logoutDidFinish(response: response)}
    }
}
