//
//  FStoreModel.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 20.04.2024.
//

import Foundation

struct FStoreMessageResponse {
    let error: ErrorResponse
    let result: [Message]?
}

protocol FStoreObserver : AnyObject {
    func addMessageDidFinish (response: FStoreMessageResponse)
    func getMessagesDidFinish (response: FStoreMessageResponse)
}

extension FStoreObserver {
    func addMessageDidFinish (response: FStoreMessageResponse) {}
    func getMessagesDidFinish (response: FStoreMessageResponse) {}
}

struct WeakFStoreObserver {
    weak var value : FStoreObserver?
}
