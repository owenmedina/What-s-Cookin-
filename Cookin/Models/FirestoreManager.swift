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

protocol FirestoreManagerUpdaterDelegate {
    func didFailToUpdateUserImage(withError error: Error)
}

protocol FirestoreManagerActivityDelegate {
    func didAddNewActivity(_ manager: FirestoreManager, activity: Activity)
    func didFailToAddActivity(withError error: Error)
    func didGetActivities(_ manager: FirestoreManager, activities: [Activity])
    func didFailToGetActivities(withError error: Error)
}

class FirestoreManager {
    let db = Firestore.firestore()
    var registerDelegate: FirestoreManagerRegisterDelegate?
    var loginDelegate: FirestoreManagerLogInDelegate?
    var updaterDelegate: FirestoreManagerUpdaterDelegate?
    var activityDelegate: FirestoreManagerActivityDelegate?
    var isFetchingActivities = false
    private var lastActivityReference: DocumentSnapshot?
    
    func addNewObject<T: Encodable>(_ object: T, to collection: String, withID id: String) -> Error? {
        do {
            try db.collection(collection).document(id).setData(from: object)
            return nil
        } catch let error {
            print("Error writing to collection \(collection) with id \(id)")
            return error
        }
    }
    
    func addNewObject(fromDictionary dictionary: [String: Any], to collection: String, withID id: String) -> Error? {
        do {
            try db.collection(collection).document(id).setData(dictionary)
            return nil
        } catch let error {
            return error
        }
    }
    
    func addNewUser(_ user: User, withID id: String) {
        do {
            try db.collection(K.Firebase.Firestore.Collections.Users.collectionName).document(id).setData(from: user)
            registerDelegate?.didAddNewUser(self, user: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            registerDelegate?.didFailToAddNewUser(withError: error)
        }
    }
    
    func addNewActivity(_ activity: Activity, toUser id: String) {
        do {
            try db.collection(K.Firebase.Firestore.Collections.Users.collectionName).document(id).collection(K.Firebase.Firestore.Collections.Users.Activities.collectionName).addDocument(from: activity)
            activityDelegate?.didAddNewActivity(self, activity: activity)
        } catch let error {
            print("Error writing activity to Firestore")
            activityDelegate?.didFailToAddActivity(withError: error)
        }
    }
    
    func getActivities(forUser id: String, fromBeginning: Bool = false, numberOfActivities: Int = K.Firebase.Firestore.Collections.Users.Activities.defaultNumberOfActivitiesToFetch) {
        isFetchingActivities = true
        var docRef = db.collection(K.Firebase.Firestore.Collections.Users.collectionName).document(id).collection(K.Firebase.Firestore.Collections.Users.Activities.collectionName).order(by: K.Firebase.Firestore.Collections.Users.Activities.dateField, descending: true).limit(to: numberOfActivities)
        if lastActivityReference != nil && !fromBeginning {
            print("There was a previous activity: \(lastActivityReference!.documentID)")
            docRef = docRef.start(afterDocument: lastActivityReference!)
        } else {
            print("From beginning: \(fromBeginning)")
        }
        docRef.getDocuments { (querySnapshot, error) in
            guard error == nil else {
                print("Document does not exist. Error reading activity from Firestore: \(error!)")
                self.activityDelegate?.didFailToGetActivities(withError: error!)
                self.isFetchingActivities = false
                return
            }
            
            var activities = [Activity]()
            
            for document in querySnapshot!.documents {
                if let activity = Activity.fromQueryDocumentSnapshot(document) {
                    activities.append(activity)
                }
            }
            if let lastSnapshot = querySnapshot?.documents.last {
                self.lastActivityReference = lastSnapshot
            }
            self.isFetchingActivities = false
            self.activityDelegate?.didGetActivities(self, activities: activities)
        }
//        docRef.getDocuments { (document, error) in
//            if error != nil {
//                print("Document does not exist. Error reading activity from Firestore: \(error!)")
//                activityDelegate?.didFailToGetActivities(withError: error!)
//            } else if let document = document, document.exists {
//
//                let id = document.documentID
//                guard let data = document.data() else {
//                    print("Cannot create Activity from dictionary: Document Snapshot has no data")
//                    activityDelegate?.didFailToGetActivities(withError: FirestoreError.couldNotGetActivities)
//                }
//                guard let action = data[K.Firebase.Firestore.Collections.Activities.actionField] as? String, let object = data[K.Firebase.Firestore.Collections.Activities.objectField] as? String, let objectType = data[K.Firebase.Firestore.Collections.Activities.objectTypeField] as? String else {
//                    print("Cannot create Activity from dictionary: One or more of the fields could not be extracted")
//                    activityDelegate?.didFailToGetActivities(withError: FirestoreError.couldNotGetActivities)
//                }
//                switch objectType {
//                case ObjectType.recipe.rawValue:
//                    // decode recipe
//                    guard let recipe = Recipe.fromDictionary(objectDictionary) else {
//                        print("Cannot create Activity from dictionary: Recipe.fromDictionary() returned nil")
//                        activityDelegate?.didFailToGetActivities(withError: FirestoreError.couldNotGetActivities)
//                    }
//                    let activity = Activity(action: Action(rawValue: action)!, object: recipe)
//                case ObjectType.user.rawValue:
//                    // decode user
//                    let user = User.fromDictionary(objectDictionary)
//                //            return Activity(action: action, object: user)
//                default:
//                    print(K.Error.unrecognizedObject)
//                    return
//                }
//
//            }
//        }
    }
    
    func getUser(withID id: String) {
        let docRef = db.collection(K.Firebase.Firestore.Collections.Users.collectionName).document(id)
        docRef.getDocument { (document, error) in
            if error != nil {
                print("Document does not exist. Error reading user from Firestore: \(error!)")
                self.loginDelegate?.didFailToGetUser(withError: error!)
            } else if let document = document, document.exists {
                // test code
                if let user = User.createUserFromDocument(document) {
                    print("User data: \(user.name)")
                    self.loginDelegate?.didGetUser(self, user: user)
                } else {
                    print("Couldn't create user from dict")
                    self.loginDelegate?.didFailToGetUser(withError: FirestoreError.couldNotGetUser)
                }
            } else {
                self.loginDelegate?.didFailToGetUser(withError: FirestoreError.userDoesNotExist)
            }
        }
    }
    
    func updateUserImageURL(_ url: URL, forID id: String) {
        print("Entered updateUserImageURL")
        let docRef = db.collection(K.Firebase.Firestore.Collections.Users.collectionName).document(id)
        docRef.updateData([K.Firebase.Firestore.Collections.Users.imageURLField: url.absoluteString]) { (error) in
            if error != nil {
                self.updaterDelegate?.didFailToUpdateUserImage(withError: error!)
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
    case couldNotGetActivities
    case unknownError

    var message: String {
        switch self {
        case .couldNotAddNewUser:
            return K.Firebase.Firestore.Error.couldNotAddNewUser
        case .couldNotGetUser:
            return K.Firebase.Firestore.Error.couldNotGetUser
        case .userDoesNotExist:
            return K.Firebase.Firestore.Error.userDoesNotExist
        case .couldNotGetActivities:
            return K.Firebase.Firestore.Error.couldNotGetActivities
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
