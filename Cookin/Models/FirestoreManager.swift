//
//  FirestoreManager.swift
//  Cookin
//
//  Created by Owen Medina on 11/20/20.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FirestoreManager {
    let db = Firestore.firestore()
    func addNewUser(_ user: User, withID id: String) -> Error? {
        do {
            try db.collection(K.Firebase.Firestore.usersCollection).document(id).setData(from: user)
            return nil
        } catch let error {
            print("Error writing city to Firestore: \(error)")
            return error
        }
    }
}
