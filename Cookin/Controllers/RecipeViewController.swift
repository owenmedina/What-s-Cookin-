//
//  RecipeViewController.swift
//  Cookin
//
//  Created by Owen Medina on 12/2/20.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI
            // Recipe Image
        recipeImageView.image = recipe?.image
        recipeImageView.layer.cornerRadius = K.ImageView.standardCornerRadius
        recipeImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
}
