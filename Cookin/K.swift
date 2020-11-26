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
    // Alert
    struct Alert {
        static let ok = "Ok"
        static let error = "Error"
    }
    // APIs
    struct API {
        struct Spoonacular {
            static let complexSearchEndpoint = "https://api.spoonacular.com/recipes/complexSearch?instructionsRequired=true&limitLicense=true&number=1&sort=healthiness&addRecipeInformation=true&query="
            static let addRecipeInformation = "addRecipeInformation"
            static let addRecipeNutrition = "addRecipeNutrition"
        }
        
        struct TheMealDB {
            static let recipeByNameEndpoint = "https://www.themealdb.com/api/json/v1/1/search.php?s="
            static let randomeRecipeEndpoint = "https://www.themealdb.com/api/json/v1/1/random.php"
            static let recipeNameKey = "strMeal"
            static let recipeInstructionsKey = "strInstructions"
            static let imageURLKey = "strMealThumb"
            static let ingredientBaseKey = "strIngredient"
            static let ingredientMeasureBaseKey = "strMeasure"
            static let stepsSeparator = "\r\n"
        }
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
        static let couldNotCreateURLFromString = "Invalid URL String:"
        static let dataReturnedWasNil = "Data returned was nil"
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
    
    // Shadows
    static let standardShadowWidth: CGFloat = 3
    static let standardShadowHeight: CGFloat = 3
    static let standardShadowOpacity: Float = 0.4
    static let standardShadowRadius: CGFloat = 4
}
