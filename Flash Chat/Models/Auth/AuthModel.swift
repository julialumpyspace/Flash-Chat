//
//  AuthModel.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import Foundation
import FirebaseAuth

struct AuthResponse {
    let error: ErrorResponse?
    let result: AuthDataResult?
}
