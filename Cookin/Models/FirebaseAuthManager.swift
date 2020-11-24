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
    func didFailWithError(_ error: AuthErrorCode?)
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
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let existingError = error {
                delegate?.didFailWithError(handleError(existingError))
                return
            }
            // Store user information in users collection
            let user = User(name: name) // add user info
            let error = firestoreManager.addNewUser(user, withID: authResult!.user.uid)
            if let existingError = error {
                delegate?.didFailWithError(handleError(existingError))
                return
            }
            delegate?.didSignIn(self)
        }
    }
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let existingError = error {
                delegate?.didFailWithError(handleError(existingError))
                return
            }
            delegate?.didSignIn(self)
        }
    }
    
    func handleError(_ error: Error) -> AuthErrorCode? {
        return AuthErrorCode(rawValue: error._code)
    }
}

extension AuthErrorCode {
    var message: String {
        switch self {
        case .operationNotAllowed:
            print(K.Firebase.Auth.Error.operationNotAllowed)
            return K.Firebase.Auth.Error.unknownError
        case .emailAlreadyInUse:
            return K.Firebase.Auth.Error.emailAlreadyInUse
        case .userNotFound:
            return K.Firebase.Auth.Error.userNotFound
        case .userDisabled:
            return K.Firebase.Auth.Error.userDisabled
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return K.Firebase.Auth.Error.invalidEmail
        case .networkError:
            return K.Firebase.Auth.Error.networkError
        case .weakPassword:
            return K.Firebase.Auth.Error.weakPassword
        case .wrongPassword:
            return K.Firebase.Auth.Error.wrongPassword
        default:
            return K.Firebase.Auth.Error.unknownError
        }
    }
}
