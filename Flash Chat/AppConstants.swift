//
//  AppConstants.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 18.04.2024.
//

import Foundation

struct K {
    static let AppTitle = "Flash Chat"
    static let AppTitleMessage: String = "Hi! How’s old socks?\nThis is a flash chat!"
    static let Segue_RegisterToChat_ID: String = "fromRegisterToChat"
    static let Segue_LoginToChat_ID: String = "fromLoginToChat"
    static let TableCell_ID = "ReusebleCell"
    static let CellNib_ID = "MessageCell"
    
    struct BrandColors {
        static let Purple = "BrandPink"
        static let LightPurple = "BrandLightPink"
        static let Blue = "BrandBlue"
        static let LighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let CollectionName = "messages"
        static let SenderField = "sender"
        static let BodyField = "body"
        static let DateField = "date"
    }
}
