//
//  FirebaseAuthManager.swift
//  Cookin
//
//  Created by Owen Medina on 11/19/20.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthManagerDelegate {
    func didFailWithFirebaseAuthError(_ error: AuthErrorCode?)
}

protocol FirebaseAuthManagerRegisterDelegate {
    func didRegister(_ firebaseAuthManager: FirebaseAuthManager, user: User)
}

protocol FirebaseAuthManagerLogInDelegate {
    func didLogIn(_ firebaseAuthManager: FirebaseAuthManager, userID: String)
}

struct FirebaseAuthManager {
    let firestoreManager = FirestoreManager()
    var delegate: FirebaseAuthManagerDelegate?
    var registerDelegate: FirebaseAuthManagerRegisterDelegate?
    var loginDelegate: FirebaseAuthManagerLogInDelegate?
    var currentUser: FirebaseAuth.User? {
        get {
            return Auth.auth().currentUser
        }
    }
    
    func registerUser(withEmail email: String, name: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let existingError = error {
                delegate?.didFailWithFirebaseAuthError(handleError(existingError))
                return
            }
            let user = User(id: authResult!.user.uid, name: name)
            registerDelegate?.didRegister(self, user: user)
        }
    }
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let existingError = error {
                delegate?.didFailWithFirebaseAuthError(handleError(existingError))
                return
            }
            loginDelegate?.didLogIn(self, userID: authResult!.user.uid)
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
