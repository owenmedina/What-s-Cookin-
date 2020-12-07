//
//  K.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/17/20.
//

import Foundation
import UIKit

struct K {
    // Accessibility
    struct Accessibility {
        // Identifiers
        static let emailTextFieldIdentifier = "Email Text Field"
        static let emailValidationLabelIdentifier = "Email Validation Error"
        static let passwordTextFieldIdentifier = "Password Text Field"
        static let passwordValidationLabelIdentifier = "Password Validation Error"
        static let nameTextFieldIdentifier = "Name Text Field"
        static let nameValidationLabelIdentifier = "Name Validation Error"
        // Labels
        static let emailTextFieldLabel = "Email"
        static let passwordTextFieldLabel = "Password"
        static let nameTextFieldLabel = "Name"
    }
    struct Alert {
        static let ok = "Ok"
        static let error = "Error"
    }
    // Animations
    static let standardAnimationDuration = 0.25
    static let shortAnimationDuration = 0.10
    // Buttons
    static let buttonRadius = CGFloat(25)
    static let buttonBorderWidth = CGFloat(1)
    // Colors
    static let red = UIColor(named: "Red")!
    static let yellow = UIColor(named: "Yellow")!
    static let orange = UIColor(named: "Orange")!
    // Error messages
    struct Error {
        static let emptyTextField = "must not be empty."
        static let invalidPassword = "Password must be at least 8 characters long and contain 1 letter and 1 number."
        static let invalidEmail = "Email must be a valid email."
        static let incorrectPassword = "Password is incorrect."
    }
    // Firebase
    struct Firebase {
        // Auth
        struct Auth {
            // Errors
            struct Error {
                static let noUID = "Could not find user ID."
                static let emailAlreadyInUse = "Email is already in use with another account."
                static let userNotFound = "No account found for that user. Please check and try again."
                static let userDisabled = "Your account has been disabled. Please contact support."
                static let invalidEmail = "Email must be a valid email."
                static let networkError = "Network error. Please try again."
                static let weakPassword =  "Password is too weak. Password must be 6 characters long or more."
                static let wrongPassword = "Password is incorrect."
                static let unknownError = "Unknown error occurred. Please try again later."
                static let operationNotAllowed = "Email and password accounts are not enabled. Enable them in the Auth section of the Firebase console."
            }
        }
        // Firestore
        struct Firestore {
            struct Collections {
                struct Users {
                    static let collectionName = "users"
                    static let idField = "id"
                    static let nameField = "name"
                }
            }
            struct Error {
                static let couldNotAddNewUser = "Trouble adding new user to Cookin' database. Please try again."
                static let couldNotGetUser = "Trouble retrieving user information from Cookin' database. Please try again."
                static let userDoesNotExist = "User or user's data does not exist. Please try a different user."
                static let unableToPerformOperation = "Unable to perform operation. Please contact support regading this issue."
                static let couldNotPerformOperation = "Could not complete operation. Please try again later."
                static let unknownError = "Unknown error occurred. Please try again and contact support if problem persists."
                static let alreadyExists = "Could not complete operation. Data to be saved already exists on database. "
                static let notFound = "Data could not be found. Please contact support if problem persists."
                static let resourceExhausted = "Operation could not be completed. Either app or user has reached operation limits. Please try again later and contact support if problem persists."
                static let unauthenticated = "Must be signed in to perform operation. Please sign in then try again."
                static let unimplemented = "Application does not currently support this feature. Contact support regarding your interest in it."
            }
        }
    }
    // Regular Expressions
    // ^ start of regex, $ end of regex, ?=.*[A-za-z] at least one numeric, ?=.*\\d at least one number, [A-Za-z\\d] any number of alphanumerics, {8,} 8 or more characters
    static let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        // First part is user-defined then @ then the server portion (punctuated with a .) then the TLD section
    static let emailRegex = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?" + "@" + "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}" + "[A-Za-z]{2,8}"
    // Segues
    static let loginToHome = "LoginToHome"
    static let registerToHome = "RegisterToHome"
    static let welcomeToRegister = "WelcomeToRegister"
    static let welcomeToLogin = "WelcomeToLogin"
}
