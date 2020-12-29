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

protocol FirestoreManagerRegisterDelegate {
    func didAddNewUser(_ manager: FirestoreManager, user: User)
    func didFailToAddNewUser(withError error: Error)
}

protocol FirestoreManagerLogInDelegate {
    func didGetUser(_ manager: FirestoreManager, user: User)
    func didFailToGetUser(withError error: Error)
}

struct FirestoreManager {
    let db = Firestore.firestore()
    var registerDelegate: FirestoreManagerRegisterDelegate?
    var loginDelegate: FirestoreManagerLogInDelegate?
    
    func addNewUser(_ user: User, withID id: String) {
        do {
            try db.collection(K.Firebase.Firestore.Collections.Users.collectionName).document(id).setData(from: user)
            registerDelegate?.didAddNewUser(self, user: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            registerDelegate?.didFailToAddNewUser(withError: error)
        }
    }
    
    func getUser(withID id: String) {
        let docRef = db.collection(K.Firebase.Firestore.Collections.Users.collectionName).document(id)
        docRef.getDocument { (document, error) in
            if error != nil {
                print("Document does not exist. Error reading user from Firestore: \(error!)")
                loginDelegate?.didFailToGetUser(withError: error!)
            } else if let document = document, document.exists {
                // test code
                if let user = User.createUserFromDocument(document) {
                    print("User data: \(user.name)")
                    loginDelegate?.didGetUser(self, user: user)
                } else {
                    print("Couldn't create user from dict")
                    loginDelegate?.didFailToGetUser(withError: FirestoreError.couldNotGetUser)
                }
            } else {
                loginDelegate?.didFailToGetUser(withError: FirestoreError.userDoesNotExist)
            }
        }
    }
    
    func handleError(_ error: Error) -> FirestoreErrorCode {
        if let errorCode = FirestoreErrorCode(rawValue: error._code) {
            return errorCode
        }
        return .unknown
    }
}

enum FirestoreError: Error {
    case couldNotAddNewUser
    case couldNotGetUser
    case userDoesNotExist
    case unknownError

    var message: String {
        switch self {
        case .couldNotAddNewUser:
            return K.Firebase.Firestore.Error.couldNotAddNewUser
        case .couldNotGetUser:
            return K.Firebase.Firestore.Error.couldNotGetUser
        case .userDoesNotExist:
            return K.Firebase.Firestore.Error.userDoesNotExist
        default:
            return K.Firebase.Auth.Error.unknownError
        }
    }
}

extension FirestoreErrorCode {
    var message: String {
        switch self {
        case .cancelled, .aborted, .unavailable:
            // Tell user to retry operation
            return K.Firebase.Firestore.Error.couldNotPerformOperation
        case .invalidArgument, .dataLoss, .failedPrecondition, .internal, .outOfRange:
            // Tell user to contact support
            return K.Firebase.Firestore.Error.unableToPerformOperation
        case .alreadyExists:
            return K.Firebase.Firestore.Error.alreadyExists
        case .notFound:
            return K.Firebase.Firestore.Error.notFound
        case .resourceExhausted:
            return K.Firebase.Firestore.Error.resourceExhausted
        case .unauthenticated:
            return K.Firebase.Firestore.Error.unauthenticated
        case .unimplemented:
            return K.Firebase.Firestore.Error.unimplemented
        case .unknown, .deadlineExceeded, .permissionDenied:
            // Unsure if error caused by client or system or server so have the user try again then contact support
            fallthrough
        default:
            return K.Firebase.Firestore.Error.unknownError
        }
    }
}
