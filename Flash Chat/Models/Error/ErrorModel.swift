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

struct ErrorMessage {
    static func emptyField (fieldName: String) -> String {
        return "The field \(fieldName) is empty. Please fill in the field!"
    }
    
    static func requestError() -> String {
        return "The error occured in a request. Try later or check the data!"
    }
    
}

