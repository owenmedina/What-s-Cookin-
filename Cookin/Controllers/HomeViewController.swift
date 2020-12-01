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
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionViewFlowLayout: UICollectionViewFlowLayout!
    fileprivate var recipeManager = RecipeManager()
    fileprivate var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup delegates
        recipeManager.delegate = self
        categoriesCollectionView.delegate = self
        
        categoriesCollectionView.dataSource = self
        
        // Load up data
        recipeManager.fetchRandomRecipe()
        
        // Setup UI
        // Featured Image View
        featuredImageView.layer.cornerRadius = K.View.standardCornerRadius
        // Setup Skeleton UI
        activateSkeletonView()
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
            let text = [K.HomeViewController.featuredRecipeTitle: recipe.title]
            let images = [K.HomeViewController.featuredRecipeImage: recipe.image]
            self.updateViewsWithContent(text: text, images: images)
        }
        
    }
    
    func didFailWithError(_ error: Error) {
        //TODO
        print("Complete Implementation: HomeViewController.didFailWithError(): \(error)")
    }
}

//MARK: - Skeleton UI Methods
extension HomeViewController {
    fileprivate func activateSkeletonView() {
        // Blur Navigation Bar Title
        if let navigationBar = self.navigationController?.navigationBar {
            blurView.frame = navigationBar.bounds
            self.navigationController?.navigationBar.addSubview(blurView)
        }
        // Hide labels on the Card Views
        titleLabel.isHidden = true
    }
    
    fileprivate func updateViewsWithContent(text: [String: String?], images: [String: UIImage?]) {
        DispatchQueue.main.async {
            // Unblur Navigation Bar Title
            self.blurView.effect = nil
            
            // Bring back labels (with proper content)
            self.titleLabel.isHidden = false
            self.titleLabel.text = text[K.HomeViewController.featuredRecipeTitle] as? String
            
            // Bring in images
            self.featuredImageView.image = images[K.HomeViewController.featuredRecipeImage] as? UIImage
        }
    }
}

//MARK: - Collection View Methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.RecipeCollectionViewCell.identifier, for: indexPath) as! RecipeCollectionViewCell
        cell.titleLabel.text = Categories.allCases[indexPath.row].rawValue.uppercased()
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width * 0.4, height: collectionView.bounds.size.width * 0.4)
    }
}
