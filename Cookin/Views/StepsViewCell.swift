//
//  StepsViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//  Represents Steps section in the Recipe View

import UIKit

class StepsViewCell: UICollectionViewCell {
    var steps: [String]?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.separatorStyle = .none
        tv.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
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
        tableView.register(UINib(nibName: K.StepsTableView.StepsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: K.StepsTableView.StepsTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableViewDelegate Methods
extension StepsViewCell: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource Methods
extension StepsViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.StepsTableView.StepsTableViewCell.identifier, for: indexPath) as! StepsTableViewCell
        cell.stepLabel.text = "\(indexPath.item + 1). \(steps?[indexPath.item] ?? "")"
        
        return cell
    }
}
