//
//  FStoreManager.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 20.04.2024.
//

import Foundation
import FirebaseFirestore

class FStoreManager {
    private lazy var observers: [WeakFStoreObserver] = []
    
    let db = Firestore.firestore()
    
    func add(message: Message)  {
        let dbData = [
            K.FStore.SenderField: message.sender,
            K.FStore.BodyField: message.body,
            K.FStore.DateField: message.date
        ]
        
        db.collection(K.FStore.CollectionName).addDocument(data: dbData) { error in
            var errorResponse: ErrorResponse = ErrorResponse(error: false, message: "")
            if let e = error {
                errorResponse = ErrorResponse(
                    error: true,
                    message: ErrorMessage.FStore.add(error: e))
            }
            let response: FStoreMessageResponse = FStoreMessageResponse(error: errorResponse, result: nil)
                self.notifyAddMessageDidFinish(response: response)
        }
    }
    
    func get() {
        db.collection(K.FStore.CollectionName)
            .order(by: K.FStore.DateField)
            .addSnapshotListener { (querySnapshot, error) in
                var errorResponse: ErrorResponse = ErrorResponse(error: false, message: "")
                var messages: [Message] = []
                
                if let e = error {
                    errorResponse = ErrorResponse(error: true, message: ErrorMessage.FStore.get(error: e))
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data[K.FStore.SenderField] as? String,
                               let body = data[K.FStore.BodyField] as? String,
                               let date = data[K.FStore.DateField] as? String {
                                let message = Message(
                                    sender: sender,
                                    body: body,
                                    date: date)
                                messages.append(message)
                                
                                errorResponse =  ErrorResponse(error: false, message: "")
                            } else {
                                errorResponse = ErrorResponse(error: true, message: ErrorMessage.FStore.parseDocumnetsToString)
                            }
                        }
                    } else if ((querySnapshot?.documents.count) == nil) {
                        errorResponse = ErrorResponse(error: true, message: ErrorMessage.FStore.parseDocumnetsToString)
                    } else {
                        errorResponse = ErrorResponse(error: true, message: ErrorMessage.FStore.parseDocumnetsToString)
                    }
                }
                
                let result = messages.count > 1 ? messages : nil
                let response: FStoreMessageResponse = FStoreMessageResponse(error: errorResponse, result: result)
                self.notifyGetMessageDidFinish(response: response)
                
            }
    }
    
}

// MARK: - FStoreObserver

extension FStoreManager {
    func addObserver(_ observer: FStoreObserver) {
        observers.append(WeakFStoreObserver(value: observer))
    }
    
    func removeObserver(_ observer: FStoreObserver) {
        observers.removeAll(where: { $0.value === observer })
    }
    
    func notifyAddMessageDidFinish(response: FStoreMessageResponse) {
        observers.forEach { $0.value?.addMessageDidFinish(response: response)}
    }
    
    func notifyGetMessageDidFinish(response: FStoreMessageResponse) {
        observers.forEach { $0.value?.getMessagesDidFinish(response: response)}
    }
    
}
