//
//  ErrorModel.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import UIKit

extension UITextField: ErrorUIHandler {
    func errorEmptyCheck(field: UITextField, name: String) -> ErrorResponse {
        let errorManager = ErrorManager()
        return errorManager.errorEmptyCheck(field: field, name: name)
    }
}
