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

struct ErrorResponse {
    let error: Bool
    let message: String
}

struct ErrorMessage {
    struct Auth {
        static func registration(error: String) -> String {
            return "There was an issue registrating a user: \(error)"
        }
        
        static func login(error: String) -> String {
            return "There was an issue login a user: \(error)"
        }
        
        static func logout(error: NSError) -> String {
            return "There was an issue logout a user: \(error)"
        }
    }
    
    struct FStore {
        static func add(error: Error) -> String {
            return "There was an issue saving data to Firestore: \(error)"
        }
        
        static func get(error: Error) -> String {
            return "There was an issue getting data from Firestore: \(error)"
        }
        
        static let getDocuments = "Error is occured getting documents from Shanpshot."
        static let parseDocumnetsToString = "Error is occured parsing the data fields to String."
    }
    
    struct UIField {
        static func empty(fieldName: String) -> String {
            return "The field \(fieldName) is empty. Please fill in the field!"
        }
    }
}

