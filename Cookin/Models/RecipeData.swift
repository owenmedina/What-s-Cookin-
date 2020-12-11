//
//  RecipeData.swift
//  Cookin
//
//  Created by Owen Medina on 11/25/20.
//

import Foundation

struct RecipeData: Decodable {
    var meals: [Meal]
}

struct Meal: Decodable {
    var name: String
    var instructions: String
    var imageURL: String
    var sourceURL: String?
    var origin: String
    var ingredient1: String
    var ingredient2: String
    var ingredient3: String
    var ingredient4: String
    var ingredient5: String
    var ingredient6: String
    var ingredient7: String
    var ingredient8: String
    var ingredient9: String
    var ingredient10: String
    var ingredient11: String
    var ingredient12: String
    var ingredient13: String
    var ingredient14: String
    var ingredient15: String
    var ingredient16: String
    var ingredient17: String
    var ingredient18: String
    var ingredient19: String
    var ingredient20: String
    var ingredientMeasure1: String
    var ingredientMeasure2: String
    var ingredientMeasure3: String
    var ingredientMeasure4: String
    var ingredientMeasure5: String
    var ingredientMeasure6: String
    var ingredientMeasure7: String
    var ingredientMeasure8: String
    var ingredientMeasure9: String
    var ingredientMeasure10: String
    var ingredientMeasure11: String
    var ingredientMeasure12: String
    var ingredientMeasure13: String
    var ingredientMeasure14: String
    var ingredientMeasure15: String
    var ingredientMeasure16: String
    var ingredientMeasure17: String
    var ingredientMeasure18: String
    var ingredientMeasure19: String
    var ingredientMeasure20: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
        case imageURL = "strMealThumb"
        case sourceURL = "strSource"
        case origin = "strArea"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case ingredientMeasure1 = "strMeasure1"
        case ingredientMeasure2 = "strMeasure2"
        case ingredientMeasure3 = "strMeasure3"
        case ingredientMeasure4 = "strMeasure4"
        case ingredientMeasure5 = "strMeasure5"
        case ingredientMeasure6 = "strMeasure6"
        case ingredientMeasure7 = "strMeasure7"
        case ingredientMeasure8 = "strMeasure8"
        case ingredientMeasure9 = "strMeasure9"
        case ingredientMeasure10 = "strMeasure10"
        case ingredientMeasure11 = "strMeasure11"
        case ingredientMeasure12 = "strMeasure12"
        case ingredientMeasure13 = "strMeasure13"
        case ingredientMeasure14 = "strMeasure14"
        case ingredientMeasure15 = "strMeasure15"
        case ingredientMeasure16 = "strMeasure16"
        case ingredientMeasure17 = "strMeasure17"
        case ingredientMeasure18 = "strMeasure18"
        case ingredientMeasure19 = "strMeasure19"
        case ingredientMeasure20 = "strMeasure20"
    }
}

// Spoonacular API
//struct RecipeResultsData: Codable {
//    var results: [RecipeData]
//    var totalResults: Int
//}
//
//struct RecipeData: Codable {
//    var title: String
//    var image: String
//    var sourceURL: String
//    var preparationMinutes: Int
//    var cookingMinutes: Int
//    var cuisines: [String]
//    var analyzedInstructions: [StepData]
//}
//
//struct StepData: Codable {
//    var number: Int
//    var step: String
//    var ingredients: [IngredientData]
//}
//
//struct IngredientData: Codable {
//    var name: String
//}
