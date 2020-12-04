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
    @IBOutlet weak var navigationBarTitleLabel: UILabel!
    @IBOutlet weak var featuredRecipeTitleLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionViewFlowLayout: UICollectionViewFlowLayout!
    fileprivate var recipeManager = RecipeManager()
    fileprivate var unsplashManager = UnsplashManager()
    fileprivate var featuredRecipe = Recipe(title: "", steps: [""], ingredients: [Ingredient(name: "", measure: "")], cuisine: .unknown)
    fileprivate var selectedCategory = ""
    
    // TODO: Find final solution (temporary code)
    fileprivate var images = [String: UIImage]()
    fileprivate var indexPaths = [String: IndexPath]()
    
    fileprivate var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup delegates
        recipeManager.delegate = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        unsplashManager.delegate = self
        
        // Load up data
        recipeManager.fetchRandomRecipe()
        
        // Setup UI
        // Navigation Bar
        // Setting the background image to an empty image will erase the border
        // When using a custom shadow image, a custom background image must all be provided
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        // Add a left-aligned title
//        let navigationBarLabel = UILabel()
//        navigationBarLabel.text = K.Screens.Home.title
//        navigationBarLabel.font = UIFont(name: K.Assets.Fonts.Lora.regular, size: 21)
//        navigationBarLabel.textAlignment = .left
//
//        navigationBarLabel.translatesAutoresizingMaskIntoConstraints = false
//        navigationBarLabel.superview?.addConstraint(NSLayoutConstraint(item: navigationBarLabel, attribute: .centerX, relatedBy: .equal, toItem: self.navigationItem.titleView?.superview, attribute: .centerX, multiplier: 1, constant: 0))
//        navigationBarLabel.superview?.addConstraint(NSLayoutConstraint(item: navigationBarLabel, attribute: .width, relatedBy: .equal, toItem: self.navigationItem.titleView?.superview, attribute: .width, multiplier: 1, constant: 0))
//        navigationBarLabel.superview?.addConstraint(NSLayoutConstraint(item: navigationBarLabel, attribute: .centerY, relatedBy: .equal, toItem: self.navigationItem.titleView?.superview, attribute: .centerY, multiplier: 1, constant: 0))
//        navigationBarLabel.superview?.addConstraint(NSLayoutConstraint(item: navigationBarLabel, attribute: .height, relatedBy: .equal, toItem: self.navigationItem.titleView?.superview, attribute: .height, multiplier: 1, constant: 0))
//        self.navigationItem.titleView = navigationBarLabel
        // Featured Image View
        featuredImageView.layer.cornerRadius = K.ShadowRoundedView.standardCornerRadius
        // Categories Collection View
        categoriesCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: K.CollectionView.standardTopEdgeInset, left: K.CollectionView.standardLeftEdgeInset, bottom: K.CollectionView.standardBottomEdgeInset, right: K.CollectionView.standardRightEdgeInset)
        categoriesCollectionViewFlowLayout.sectionHeadersPinToVisibleBounds = true
        categoriesCollectionViewFlowLayout.estimatedItemSize = .zero
        // Setup Skeleton UI
        activateSkeletonView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //self.categoriesCollectionViewFlowLayout.invalidateLayout()
        categoriesCollectionView.reloadData()
        featuredImageView.addPartialSemiTransparentOverlay(usingBoundsOf: featuredImageView.superview)
    }
    
    @IBAction func featuredRecipeTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: K.Segue.homeToRecipeDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.homeToRecipeDetail {
            let destination = segue.destination as! RecipeViewController
            destination.recipe = featuredRecipe
            
        } else if segue.identifier == K.Segue.homeToCategory {
            let destination = segue.destination as! CategoryViewController
            destination.categoryName = selectedCategory
        }
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
        featuredRecipe = recipe
        DispatchQueue.main.async {
            // Update UI
            let text = [K.HomeViewController.featuredRecipeTitle: recipe.title]
            self.images[K.HomeViewController.featuredRecipeImage] = recipe.image
            self.updateViewsWithTextContent(text)
            self.updateViewsWithImageContent()
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
        featuredRecipeTitleLabel.isHidden = true
    }
    
    fileprivate func updateViewsWithTextContent(_ text: [String: String?]) {
        DispatchQueue.main.async {
            // Unblur Navigation Bar Title
            self.blurView.effect = nil
            self.blurView.removeFromSuperview()
            
            // Bring back labels (with proper content)
            self.featuredRecipeTitleLabel.isHidden = false
            self.featuredRecipeTitleLabel.text = text[K.HomeViewController.featuredRecipeTitle] as? String
        }
    }
    
    fileprivate func updateViewsWithImageContent() {
        // Bring in images
        self.featuredImageView.image = images[K.HomeViewController.featuredRecipeImage]
    }
}

//MARK: - Collection View Methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Collection View Data Source Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.RecipeCollectionView.Cell.identifier, for: indexPath) as! RecipeCollectionViewCell
        let cellTitle = Categories.allCases[indexPath.row].rawValue.capitalized
        cell.titleLabel.text = cellTitle
        cell.image.layer.cornerRadius = K.ShadowRoundedView.standardCornerRadius
        // If reused cell already has an overlay do not add another overlay
        if cell.image.layer.sublayers?.first == nil {
            cell.image.addPartialSemiTransparentOverlay(usingBoundsOf: cell)
        }
        
        var keyword = cellTitle
        if Categories.allCases[indexPath.row] == .miscellaneous {
            keyword = K.API.Unsplash.miscellaneousKeyword.capitalized
        } else if Categories.allCases[indexPath.row] == .starter {
            keyword = K.API.Unsplash.starterKeyword.capitalized
        }
        
        if indexPaths[keyword] == nil {
            //unsplashManager.findImage(for: keyword)
            indexPaths[keyword] = indexPath
        }
        
        cell.image.image = images[keyword]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: K.RecipeCollectionView.Header.identifier, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height * 0.2)
    }
    
    //MARK: - Collection View Delegate Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width * 0.45).rounded(), height: (collectionView.frame.size.width * 0.45).rounded())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return K.CollectionView.standardLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return K.CollectionView.standardInterimSpacing
    }
    
    //MARK: - Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedCategory = Categories.allCases[indexPath.item].rawValue.capitalized
        performSegue(withIdentifier: K.Segue.homeToCategory, sender: self)
    }
    
}

//MARK: - UnplashManagerDelegate Methods
extension HomeViewController: UnsplashManagerDelegate {
    func didFailFetchingPhoto(withError error: Error) {
        print("Failed fetching photo: \(error)")
    }
    
    func didFindPhoto(_ manager: UnsplashManager, photo: Photo) {
        print("Found photo!")
        
        // TODO: Find final solution (temporary code)
        images[photo.keyword] = photo.photo
        if let indexPath = indexPaths[photo.keyword] {
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadItems(at: [indexPath])
            }
        }
        
    }
    
}
