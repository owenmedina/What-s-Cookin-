//
//  RecipeViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//  Represents a section in the Recipe View
//  Swipe to different sections using the Menu Bar on the Recipe View

import UIKit

class IngredientsViewCell: UICollectionViewCell {
    var ingredients: [Ingredient]?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add Table View
        addSubview(tableView)
        tableView.bindFrameToSuperviewBounds()
        tableView.register(UINib(nibName: K.IngredientsTableView.IngredientsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: K.IngredientsTableView.IngredientsTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableViewDelegate Methods
extension IngredientsViewCell: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource Methods
extension IngredientsViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.IngredientsTableView.IngredientsTableViewCell.identifier, for: indexPath) as! IngredientsTableViewCell
        cell.ingredientLabel.text = "\(ingredients?[indexPath.item].measure ?? "") \(ingredients?[indexPath.item].name ?? "")"
        
        return cell
    }
}
