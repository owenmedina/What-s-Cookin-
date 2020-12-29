//
//  APIManager.swift
//  Cookin
//
//  Created by Owen Medina on 11/24/20.
//

import Foundation
import UIKit

protocol RecipeManagerDelegate {
    func didFailWithError(_ error: Error)
    func didFetchRecipes(_ manager: RecipeManager, recipes: [Recipe])
    func didFetchRandomRecipe(_ manager: RecipeManager, recipe: Recipe)
}

struct RecipeManager {
    var delegate: RecipeManagerDelegate?
    
    func fetchRecipes(forKeyword keyword: String) {
        var urlString = "\(K.API.TheMealDB.recipeByNameEndpoint)\(keyword)"
        // Replace spaces with %20 for a valid URL
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        performRequest(with: urlString, randomSearch: false)
    }
    
    func fetchRandomRecipe() {
        var urlString = K.API.TheMealDB.randomeRecipeEndpoint
        // Replace spaces with %20 for a valid URL
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        performRequest(with: urlString, randomSearch: true)
    }
    
    private func performRequest(with urlString: String, randomSearch: Bool) {
        // 1. Create URL
        // URL(string:) returns an optional because the string could be wrong and thus not URL-able
        guard let url = URL(string: urlString) else {
            delegate?.didFailWithError(RecipeError("\(K.Error.couldNotCreateURLFromString) \(urlString)"))
            return
        }
        
        // 2. Create a URLSession - our "browser" that performs the networking
        let session = URLSession(configuration: .default)
        
        
        print("Did make URL from url: \(urlString)")
        
        // 3. Create a task for the URLSession
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                delegate?.didFailWithError(error!)
                return
            }
            
            guard let safeData = data else {
                delegate?.didFailWithError(RecipeError(K.Error.dataReturnedWasNil))
                return
            }
            //                // Print raw data (testing)
            //                let dataString = String(data: safeData, encoding: .utf8) // utf-8 is just standard for encoding text in websites
            //                print("safeData: \(dataString)")
            if let recipes = parseJSON(safeData) {
                if randomSearch {
                    delegate?.didFetchRandomRecipe(self, recipe: recipes[0])
                } else {
                    delegate?.didFetchRecipes(self, recipes: recipes)
                }
            }
        }
        
        // 4. Start the task
        task.resume()
        
    }
    
    private func parseJSON(_ data: Data) -> [Recipe]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: data)
            var recipes = [Recipe]()
            for mealData in decodedData.meals {
                var image: UIImage? = nil
                if let imageURL = URL(string: mealData.imageURL) {
                    if let data = try? Data(contentsOf: imageURL) {
                        image = UIImage(data: data)
                    }
                }
                
                let sourceURL = URL(string: mealData.sourceURL ?? "")
                let steps = parseSteps(mealData.instructions).filter { !$0.isEmpty }
                let ingredientNamesUnfiltered = [mealData.ingredient1, mealData.ingredient2, mealData.ingredient3, mealData.ingredient4, mealData.ingredient5, mealData.ingredient6, mealData.ingredient7, mealData.ingredient8, mealData.ingredient9, mealData.ingredient10, mealData.ingredient11, mealData.ingredient12, mealData.ingredient13, mealData.ingredient14, mealData.ingredient15, mealData.ingredient16, mealData.ingredient17, mealData.ingredient18, mealData.ingredient19, mealData.ingredient20]
                var ingredientNames = ingredientNamesUnfiltered.compactMap { $0 }
                ingredientNames = ingredientNames.filter { !$0.isEmpty }
                let ingredientMeasuresUnfiltered = [mealData.ingredientMeasure1, mealData.ingredientMeasure2, mealData.ingredientMeasure3, mealData.ingredientMeasure4, mealData.ingredientMeasure5, mealData.ingredientMeasure6, mealData.ingredientMeasure7, mealData.ingredientMeasure8, mealData.ingredientMeasure9, mealData.ingredientMeasure10, mealData.ingredientMeasure11, mealData.ingredientMeasure12, mealData.ingredientMeasure13, mealData.ingredientMeasure14, mealData.ingredientMeasure15, mealData.ingredientMeasure16, mealData.ingredientMeasure17, mealData.ingredientMeasure18, mealData.ingredientMeasure19, mealData.ingredientMeasure20]
                let ingredientMeasures = ingredientMeasuresUnfiltered.compactMap { $0 }
                var ingredients = [Ingredient]()
                for i in 0..<ingredientNames.count {
                    let ingredient = Ingredient(name: ingredientNames[i], measure: ingredientMeasures[i])
                    ingredients.append(ingredient)
                }
                let cuisine = Cuisine(rawValue: mealData.origin.lowercased()) ?? .unknown
                
                let recipe = Recipe(title: mealData.name.capitalized, image: image, sourceURL: sourceURL, steps: steps, ingredients: ingredients, cuisine: cuisine)
                
                recipes.append(recipe)
            }
            //            let recipeData = decodedData.results[0]
            //            let title = recipeData.title
            //            let imageURL = URL(string: recipeData.image)
            //            let sourceURL = URL(string: recipeData.sourceURL)
            //            let preparationTime = recipeData.preparationMinutes
            //            let cookingTime = recipeData.cookingMinutes
            //            var steps = [Step]()
            //            var ingredients = [Ingredient]() // Make sure not to add duplicates
            //            for stepData in recipeData.analyzedInstructions {
            //                let step = Step(number: stepData.number, description: stepData.step)
            //                for ingredientData in stepData.ingredients {
            //                    let ingredient = Ingredient(name: ingredientData.name)
            //                    ingredients.append(ingredient)
            //                }
            //                steps.append(step)
            //            }
            //            var cuisines = [Cuisine]()
            //            for cuisine in recipeData.cuisines {
            //                if let newCuisine = Cuisine.init(rawValue: cuisine.camelCase()) {
            //                    cuisines.append(newCuisine)
            //                } else {
            //                    print("Cuisine could not be added: \(cuisine)")
            //                }
            //            }
            //            let recipe = Recipe(title: title, imageURL: imageURL, sourceURL: sourceURL, preparationTime: preparationTime, cookingTime: cookingTime, steps: steps, ingredients: ingredients, cuisines: cuisines)
            return recipes
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    private func parseSteps(_ rawSteps: String) -> [String] {
        let steps = rawSteps.components(separatedBy: K.API.TheMealDB.stepsSeparator)
        return steps
    }
}

class RecipeError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}
