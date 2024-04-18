//
//  ErrorManager.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import UIKit

struct ErrorManager: ErrorUIHandler {
    let noError = ErrorResponse(error: false, message: "")
    
    func errorEmptyCheck(field: UITextField, name: String) -> ErrorResponse {
        if field.text == nil || field.text == "" {
            let message = ErrorMessage.emptyField(fieldName: name)
            return ErrorResponse(error: true, message: message)
        } else {
            return noError
        }
    }
    
    static func getCombinedErrorMessages (errorFields: [ErrorResponse]) -> String {
        var errorMassage = ""
        for errField in errorFields {
            errorMassage += errField.error == true ? errField.message + "\n\n" : ""
        }
        return errorMassage
    }
}
