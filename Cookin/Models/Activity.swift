//
//  Activity.swift
//  Cookin
//
//  Created by Owen Medina on 12/30/20.
//

import Foundation
import Firebase



struct Activity: Codable {
    var action: Action
    var object: String
    var objectType: ObjectType
    var date: Date
    
    init(action: Action, object: String, date: Date, objectType: ObjectType = .unrecognized) {
        self.action = action
        self.object = object
        self.date = date
        self.objectType = objectType
    }
    
    static func fromQueryDocumentSnapshot(_ documentSnapshot: QueryDocumentSnapshot) -> Activity? {
        let data = documentSnapshot.data()
        guard let actionRaw = data[K.Firebase.Firestore.Collections.Users.Activities.actionField] as? String, let object = data[K.Firebase.Firestore.Collections.Users.Activities.objectField] as? String, let timestamp = data[K.Firebase.Firestore.Collections.Users.Activities.dateField] as? Timestamp, let objectTypeRaw = data[K.Firebase.Firestore.Collections.Users.Activities.objectTypeField] as? String else {
            print("Cannot create Activity from dictionary: One or more of the fields could not be extracted")
            return nil
        }
        let action = Action(rawValue: actionRaw) ?? .unknown
        let date = timestamp.dateValue()
        let objectType = ObjectType(rawValue: objectTypeRaw) ?? .unrecognized
        return Activity(action: action, object: object, date: date, objectType: objectType)
    }
}

enum Action: String, Codable {
    case viewed // recipe
    case made // recipe
    case liked // recipe
    case wrote // recipe
    case followed // user
    case unknown
}

enum ObjectType: String, Codable {
    case recipe
    case user
    case unrecognized
}

class ActivityError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}
