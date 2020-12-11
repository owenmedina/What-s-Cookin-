//
//  RecipeViewController.swift
//  Cookin
//
//  Created by Owen Medina on 12/2/20.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var ingredientsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stepsTableView: UITableView!
    @IBOutlet weak var stepsTableViewHeight: NSLayoutConstraint!
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Delegates
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        
        // Setup UI
            // Recipe Image
        recipeImageView.image = recipe?.image
        recipeImageView.layer.cornerRadius = K.ImageView.standardCornerRadius
        recipeImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            // Recipe Title Label
        recipeTitleLabel.text = recipe?.title
//        stepsTableViewHeight.constant = stepsTableView.contentSize.height
    }
    
    
}

//MARK: - UITableView Delegate Methods
extension RecipeViewController: UITableViewDelegate {
    
}

//MARK: - UITableView Data Source Methods
extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientsTableView {
            return recipe?.ingredients.count ?? 0
        } else {
            return recipe?.steps.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ingredientsTableViewHeight.constant = tableView.contentSize.height
        if tableView == ingredientsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.IngredientsTableViewCell.identifier) as! IngredientsTableViewCell
            let ingredient = recipe?.ingredients[indexPath.row]
            cell.backgroundColor = .systemGray6
            cell.label.text = "\(ingredient?.measure) \(ingredient?.name)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.StepsTableViewCell.identifier) as! StepsTableViewCell
            cell.backgroundColor = .systemGray6
            cell.label.text = recipe?.steps[indexPath.row]
            return cell
        }
    }
    
    
}
