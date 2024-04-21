//
//  MessageManager.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 20.04.2024.
//

import Foundation

struct MessageManager {
    let user = AuthManager().getAuthorizedUser()
    
    func createMessage(message: String?) -> Message? {
        if let sender = user, let body = message {
            return Message(
                sender: sender,
                body: body,
                date: "\(Date())"
            )
        } else {
            return nil
        }
    }
}
