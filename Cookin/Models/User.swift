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
    let imageURL: String?
    
    init(id: String, name: String, imageURL: String? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    static func createUserFromDocument(_ documentSnapshot: DocumentSnapshot) -> User? {
        let id = documentSnapshot.documentID
        guard let data = documentSnapshot.data() else {
            return nil
        }
        guard let name = data[K.Firebase.Firestore.Collections.Users.nameField] as? String else {
            return nil
            
        }
        if let imageURL = data[K.Firebase.Firestore.Collections.Users.imageURLField] as? String {
            return User(id: id, name: name, imageURL: imageURL)
        }
        return User(id: id, name: name)
    }
    
    // TODO: Find a better solution to replace Singleton
    static var shared = User(id: "", name: "")
}
