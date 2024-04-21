//
//  FStoreManager.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 20.04.2024.
//

import Foundation
import FirebaseFirestore

struct FStoreManager {
    let db = Firestore.firestore()
    let user = AuthManager().getAuthorizedUser()
    
    func collect(message: String)  {
        if user != nil {
            print("User", user!)
            let dbData: [String : Any] = [
                K.FStore.SenderField: user!,
                K.FStore.BodyField: message
            ]
            db.collection(K.FStore.CollectionName).addDocument(data: dbData) { error in
                if let e = error {
                    print("There was an issue saving data to Firestore: \(e)")
                } else {
                    print("Successfully saved data!")
                }
            }
            
        } else {
            print("No user")
        }
    }
    
    func get() {
        
    }
    
}
