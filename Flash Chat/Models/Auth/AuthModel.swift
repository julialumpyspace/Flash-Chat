//
//  AuthModel.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import Foundation
import FirebaseAuth

struct AuthResponse {
    let error: ErrorResponse
    let result: AuthDataResult?
}

protocol AuthObserver : AnyObject {
    func registrationDidFinish (response: AuthResponse)
    func loginDidFinish (response: AuthResponse)
    func logoutDidFinish (response: AuthResponse)
}

extension AuthObserver {
    func registrationDidFinish (response: AuthResponse) {}
    func loginDidFinish (response: AuthResponse) {}
    func logoutDidFinish (response: AuthResponse) {}
}

struct WeakAuthObserver {
    weak var value : AuthObserver?
}
