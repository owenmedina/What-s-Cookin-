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
    
    // Animations
    static let standardAnimationDuration = 0.25
    // Buttons
    static let buttonRadius = CGFloat(25)
    static let buttonBorderWidth = CGFloat(1)
    // Colors
    static let red = UIColor(named: "Red")!
    static let yellow = UIColor(named: "Yellow")!
    static let orange = UIColor(named: "Orange")!
    // Error messages
    static let emptyTextField = "must not be empty."
    static let invalidPassword = "Password must be at least 8 characters long and contain 1 letter and 1 number."
    static let invalidEmail = "Email must be a valid email."
    // Firebase
    struct Firebase {
        // Auth
        struct Auth {
            // Errors
            static let noUID = "Could not find user ID."
        }
        // Firestore
        struct Firestore {
            static let usersCollection = "users"
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
