//
//  ErrorData.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import UIKit

protocol ErrorUIHandler {
    func errorEmptyCheck (field: UITextField, name: String) -> ErrorResponse
}

struct ErrorMessageData {
    let fieldName: String
    var empty: String {
        return "The field \(fieldName) is empty. Please fill in the field!"
    }
}

struct ErrorResponse {
    let error: Bool
    let message: String
}
