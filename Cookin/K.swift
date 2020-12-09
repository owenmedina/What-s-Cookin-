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
            static let numberOfCuisines = 24 // Excluding Unknown
            static let numberOfCategories = 13 // Excluding Miscellaneous
        }
        
        struct Unsplash {
            struct Error {
                static let couldNotCreateURLForPhotoSearch = "Could not create URL for fetching photo."
                static let couldNotCreateURLForCreatingImage = "Could not create URL for creating image."
                static let couldNotAccessData = "Could not access data."
                static let couldNotConvertDataToUIImage = "Could not convert data to UIImage."
                static let couldNotGetDataFromImageURL = "Could not get data from image URL."
                static let couldNotCreateImageFromData = "Could not create image from data."
                static let noResultsFound = "No results found."
            }
            struct Plist {
                static let fileName = "Unsplash-Info"
                static let apiKey = "API_KEY"
            }
            static let searchPhotoByKeywordEndpoint = "https://api.unsplash.com/search/photos?"
            static let randomPhotoEndpoint = "https://api.unsplash.com/photos/random?"
            static let numberOfPagesParameter = "page"
            static let numberOfPhotosPerPageParameter = "per_page"
            static let keywordParameter = "query"
            static let orientationParameter = "orientation"
            static let apiKeyParameter = "client_id"
            static let starterKeyword = "appetizer"
            static let miscellaneousKeyword = "exotic"
            static let dishKeyword = "dish"
        }
    }
    // Animations
    static let standardAnimationDuration = 0.25
    static let shortAnimationDuration = 0.10
    // Assets
    struct Assets {
        struct Colors {
            static let red = UIColor(named: "Red")!
            static let yellow = UIColor(named: "Yellow")!
            static let orange = UIColor(named: "Orange")!
        }
        struct Fonts {
            struct Lora {
                static let regular = "Lora-Regular"
                static let bold = "Lora-Bold"
                static let medium = "Lora-Medium"
            }
        }
    }
    // Buttons
    static let buttonRadius = CGFloat(25)
    static let buttonBorderWidth = CGFloat(1)
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
    // Screens
    struct Screens {
        struct Home {
            static let title = "Home"
        }
    }
    // Segues
    struct Segue {
        static let loginToHome = "LoginToHome"
        static let registerToHome = "RegisterToHome"
        static let welcomeToRegister = "WelcomeToRegister"
        static let welcomeToLogin = "WelcomeToLogin"
        static let homeToRecipeDetail = "HomeToRecipeDetail"
        static let homeToCategory = "HomeToCategory"
    }
    // Shadows
    static let standardShadowWidth: CGFloat = 3
    static let standardShadowHeight: CGFloat = 3
    static let standardShadowOpacity: Float = 0.4
    static let standardShadowRadius: CGFloat = 4
    
    // Transparency
    struct Transparency {
        static let clear = CGFloat(0)
        static let semiTransparent = CGFloat(0.2)
        static let midTransparent = CGFloat(0.6)
        static let semiOpaque = CGFloat(0.8)
        static let opaque = CGFloat(1)
    }
    
    // Views
    struct CollectionView {
        static let standardLineSpacing = CGFloat(8)
        static let largeLineSpacing = CGFloat(24)
        static let standardInterimSpacing = CGFloat(8)
        static let standardLeftEdgeInset = CGFloat(10)
        static let standardRightEdgeInset = CGFloat(10)
        static let standardTopEdgeInset = CGFloat(4)
        static let standardBottomEdgeInset = CGFloat(4)
        static let standardNumberOfCellsPerRow = 2
        static let largeNumberOfCellsPerRow = 3
    }
    
    struct HomeViewController {
        static let featuredRecipeTitle = "Featured Recipe Title"
        static let featuredRecipeImage = "Featured Recipe Image"
        static let numberOfPlaceholderCells = 4
    }
    
    struct RecipeCollectionView {
        struct Cell {
            static let identifier = "Recipe Collection View Cell"
        }
        struct Header {
            static let identifier = "Recipe Collection View Header"
        }
        
    }
    
    struct ShadowRoundedView {
        static let standardCornerRadius = CGFloat(15)
        static let largeCornerRadius = CGFloat(20)
    }
}
