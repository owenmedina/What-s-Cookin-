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
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    var ingredients: [Ingredient]?
    private var currentUser: User?
    private var firestoreManager = FirestoreManager()
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.numberOfMenuItems = K.RecipeViewController.numberOfMenuItems
        mb.menuItemTitles = K.RecipeViewController.menuItemTitles
        return mb
    }()
//    @IBOutlet weak var ingredientsTableView: UITableView!
//    @IBOutlet weak var ingredientsTableViewHeight: NSLayoutConstraint!
//    @IBOutlet weak var stepsTableView: UITableView!
//    @IBOutlet weak var stepsTableViewHeight: NSLayoutConstraint!
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup current user
        currentUser = (tabBarController as! CookinTabBarController).currentUser
        
        // Get deep copy of ingredients to change checked property without affecting original array
        ingredients = recipe?.ingredients.clone() as! [Ingredient]
        
        // Add new "viewed" activity to user
        firestoreManager.addNewActivity(Activity(action: .viewed, object: recipe?.title ?? K.ActivitiesTableView.defaultRecipeObject, date: Date(), objectType: .recipe), toUser: currentUser?.id ?? "")
        
        // Setup UI
            // Recipe Image
        recipeImageView.image = recipe?.image
        recipeImageView.layer.cornerRadius = K.ImageView.standardCornerRadius
        recipeImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            // Recipe Title Label
        recipeTitleLabel.text = recipe?.title
            // Menu Bar
        setupMenuBar()
            // Main Body (Collection View)
        setupBodyCollectionView()
            // Steps Table View
//        stepsTableView.rowHeight = UITableView.automaticDimension
//        stepsTableView.estimatedRowHeight = K.StepsTableView.averageRowHeight
        
        // Setup Delegates
//        ingredientsTableView.delegate = self
//        ingredientsTableView.dataSource = self
//        stepsTableView.delegate = self
//        stepsTableView.dataSource = self
        bodyCollectionView.delegate = self
        bodyCollectionView.dataSource = self
        menuBar.delegate = self
        
        print(recipe?.sourceURL)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Setup Table Views heights
//        ingredientsTableViewHeight.constant = ingredientsTableView.contentSize.height
//        stepsTableViewHeight.constant = stepsTableView.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInitialMenuBarItem()
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
//        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.3, constant: 1))
//        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 1))
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: K.MenuBar.heightMultiplierFromSuperView, constant: 1).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        menuBar.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setInitialMenuBarItem() {
        menuBar.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    private func setupBodyCollectionView() {
        // Set scroll direction to horizontal so it is parallel to the direction of the horizontal bar of the menu bar
        // Also close gap between cells so pages are flush with one another
        if let flowLayout = bodyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        // Allow pages (cells) to snap into place when swiping through the different pages
        bodyCollectionView.isPagingEnabled = true
        
        bodyCollectionView.backgroundColor = .white
        
        bodyCollectionView.register(StepsViewCell.self, forCellWithReuseIdentifier: K.RecipeViewController.stepsViewCellIdentifier)
        bodyCollectionView.register(IngredientsViewCell.self, forCellWithReuseIdentifier: K.RecipeViewController.ingredientsViewCellIdentifier)
    }
}

//MARK: - UICollectionView Delegate Methods
extension RecipeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.moveHorizontalBar(to: scrollView.contentOffset.x/CGFloat(K.RecipeViewController.numberOfMenuItems))
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let menuItemSize = scrollView.frame.width
        let targetMenuItem = targetContentOffset.pointee.x / menuItemSize
        menuBar.collectionView.selectItem(at: IndexPath(item: Int(targetMenuItem), section: 0), animated: true, scrollPosition: [])
    }
}

//MARK: - UICollectionView Data Source Methods
extension RecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return K.RecipeViewController.numberOfMenuItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.RecipeViewController.stepsViewCellIdentifier, for: indexPath) as! StepsViewCell
            cell.steps = recipe?.steps
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.RecipeViewController.ingredientsViewCellIdentifier, for: indexPath) as! IngredientsViewCell
            cell.ingredients = ingredients
            return cell
        }
        
    }
    
    
}

//MARK: - UICollectionView Delegate Flow Layout Methods
extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Make each cell encompass the entire space allocated for the main body
            // I.e. each cell is a page
        let menuBarHeight = view.frame.size.height * K.MenuBar.heightMultiplierFromSuperView
        return CGSize(width: view.frame.width, height: view.frame.height - menuBarHeight)
    }
}

//MARK: - Menu Bar Delegate Methods
extension RecipeViewController: MenuBarDelegate {
    func menuItemDidGetSelected(withIndex index: Int) {
        let rect = bodyCollectionView.layoutAttributesForItem(at: IndexPath(row: index, section: 0))?.frame
        bodyCollectionView.scrollRectToVisible(rect!, animated: true)
    }
}

////MARK: - UITableView Delegate Methods
//extension RecipeViewController: UITableViewDelegate {
//    
//}
//
////MARK: - UITableView Data Source Methods
//extension RecipeViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == ingredientsTableView {
//            print("Ingredients: \(recipe?.ingredients.count ?? 0)")
//            return recipe?.ingredients.count ?? 0
//        } else {
//            print("Steps: \(recipe?.steps.count ?? 0)")
//            return recipe?.steps.count ?? 0
//        }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        ingredientsTableViewHeight.constant = tableView.contentSize.height
//        if tableView == ingredientsTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: K.IngredientsTableView.IngredientsTableViewCell.identifier) as! IngredientsTableViewCell
//            cell.backgroundColor = .systemGray6
//            if let ingredient = recipe?.ingredients[indexPath.row] {
//                cell.label.text = "\(ingredient.measure) \(ingredient.name)"
//                return cell
//            }
//            return cell
//            
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: K.StepsTableView.StepsTableViewCell.identifier) as! StepsTableViewCell
//            cell.backgroundColor = .systemGray6
//            cell.label.text = recipe?.steps[indexPath.row]
//            return cell
//        }
//    }
//    
//    
//}
