//
//  User.swift
//  Cookin
//
//  Created by Owen Medina on 11/20/20.
//

// TODO: complete fields and things necessary to be able to be encoded by Firestore APIs
import Foundation
import FirebaseFirestore

class User: Codable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    static func createUserFromDocument(_ documentSnapshot: DocumentSnapshot) -> User? {
        let id = documentSnapshot.documentID
        guard let data = documentSnapshot.data() else {
            return nil
        }
        if let name = data[K.Firebase.Firestore.Collections.Users.nameField] as? String {
            return User(id: id, name: name)
        }
        return nil
    }
    
    // TODO: Find a better solution to replace Singleton
    static var shared = User(id: "", name: "")
}
