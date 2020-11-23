//
//  FirebaseAuthManager.swift
//  Cookin
//
//  Created by Owen Medina on 11/19/20.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthManagerDelegate {
    func didSignIn(_ firebaseAuthManager: FirebaseAuthManager)
    func didFailWithError(_ error: Error)
}

struct FirebaseAuthManager {
    let firestoreManager = FirestoreManager()
    var delegate: FirebaseAuthManagerDelegate?
    var currentUser: FirebaseAuth.User? {
        get {
            return Auth.auth().currentUser
        }
    }
    func registerUser(withEmail email: String, name: String, password: String) {
        var id = ""
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let existingError = error {
                delegate?.didFailWithError(existingError)
                return
            }
            guard let userID = authResult?.user.uid else {
                delegate?.didFailWithError(FirebaseAuthError(message: K.Firebase.Auth.noUID))
                return
            }
            id = userID
            // Store user information in users collection
            let user = User(name: name) // add user info
            let error = firestoreManager.addNewUser(user, withID: id)
            if let existingError = error {
                delegate?.didFailWithError(existingError)
                return
            }
            delegate?.didSignIn(self)
        }
    }
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let existingError = error {
                delegate?.didFailWithError(existingError)
                return
            }
            delegate?.didSignIn(self)
        }
    }
}

struct FirebaseAuthError: Error {
    var message: String
}
