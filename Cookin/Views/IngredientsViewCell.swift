//
//  IngredientsViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//  Represents a Ingredients section in the Recipe View

import UIKit

class IngredientsViewCell: UICollectionViewCell {
    var ingredients: [Ingredient]?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add Table View
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
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
        cell.ingredientCheckBox.isChecked = ingredients?[indexPath.item].checked ?? false
        return cell
    }
}
