//
//  Recipe.swift
//  Cookin
//
//  Created by Owen Medina on 11/24/20.
//

import Foundation
import UIKit

// TheMealDB API
struct Recipe {
    var title: String
    var image: UIImage?
    var sourceURL: URL?
    var steps: [String]
    var ingredients: [Ingredient]
    var cuisine: Cuisine
}

class Ingredient: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Ingredient(name: name, measure: measure, checked: checked)
    }
    
    var name: String
    var measure: String
    var checked: Bool
    
    init(name: String, measure: String, checked: Bool = false) {
        self.name = name
        self.measure = measure
        self.checked = checked
    }
//    var quantity: Double?
//    var quantityDescriptor: String
}

enum Cuisine: String {
    case american
    case british
    case canadian
    case chinese
    case dutch
    case egyptian
    case french
    case greek
    case indian
    case irish
    case italian
    case jamaican
    case kenyan
    case malaysian
    case mexican
    case moroccan
    case polish
    case russian
    case spanish
    case thai
    case tunisian
    case turkish
    case unknown
    case vietnamese
}

enum Categories: String {
    case beef
    case breakfast
    case chicken
    case dessert
    case goat
    case lamb
    case miscellaneous
    case pasta
    case pork
    case seafood
    case side
    case starter
    case vegan
    case vegetarian
    
    static let allCases: [Categories] = [.beef, .breakfast, .chicken, .dessert, .goat, .lamb, .miscellaneous, .pasta, .pork, .seafood, .side, .starter, .vegan, .vegetarian]
}

// Spoonacular API
//struct Recipe {
//    var title: String
//    var imageURL: URL?
//    var sourceURL: URL?
//    var preparationTime: Int
//    var cookingTime: Int
//    var steps: [Step]
//    var ingredients: [Ingredient]
//    var cuisines: [Cuisine]
//}
//
//struct Step {
//    var number: Int
//    var description: String
//}
//
//struct Ingredient {
//    var name: String
//  var quantity: Double
//    var unit: Unit
//}
//
//enum Unit {
//   case cups, tablespoons, teaspoons
//}
//
//enum Cuisine: String {
//    case african
//    case american
//    case british
//    case cajun
//    case caribbean
//    case chinese
//    case easternEuropean
//    case european
//    case french
//    case german
//    case greek
//    case indian
//    case irish
//    case italian
//    case japanese
//    case jewish
//    case korean
//    case latinAmerican
//    case mediterranean
//    case mexican
//    case middleEastern
//    case nordic
//    case southern
//    case spanish
//    case thai
//    case vietnamese
//}
