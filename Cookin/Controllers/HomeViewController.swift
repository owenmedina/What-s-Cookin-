//
//  HomeViewController.swift
//  Cookin
//
//  Created by Owen Medina on 11/24/20.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var titleLabel: UILabel!
    var recipeManager = RecipeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup delegates
        recipeManager.delegate = self
        
        // Load up data
        recipeManager.fetchRandomRecipe()
        
        // Setup UI
        // Featured Image View
        featuredImageView.layer.cornerRadius = K.View.standardCornerRadius
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        featuredImageView.addPartialSemiTransparentOverlay()
    }
    
}

//MARK: - RecipeManagerDelegate Methods
extension HomeViewController: RecipeManagerDelegate {
    func didFetchRecipes(_ manager: RecipeManager, recipes: [Recipe]) {
        print("didFetchRecipes in HomeViewController")
        for recipe in recipes {
            print("\(recipe.title) \(recipe.sourceURL) \(recipe.steps[0]) \(recipe.ingredients[0].name) \(recipe.ingredients[0].measure) \(recipe.cuisine.rawValue)\n")
        }
    }
    
    func didFetchRandomRecipe(_ manager: RecipeManager, recipe: Recipe) {
        print("didFetchRandomRecipe in HomeViewController")
        print("\(recipe.title) \(recipe.sourceURL) \(recipe.steps[0]) \(recipe.ingredients[0].name) \(recipe.ingredients[0].measure) \(recipe.cuisine.rawValue)")
        DispatchQueue.main.async {
            // Update UI
            self.featuredImageView.image = recipe.image
            self.titleLabel.text = recipe.title
        }
        
    }
    
    func didFailWithError(_ error: Error) {
        //TODO
        print("Complete Implementation: HomeViewController.didFailWithError(): \(error)")
    }
}
