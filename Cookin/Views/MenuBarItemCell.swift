//
//  MenuBarItemCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/17/20.
//

import UIKit

class MenuBarItemCell: UICollectionViewCell {
    let label: UILabel = {
        let menuBarItemLabel = UILabel()
        menuBarItemLabel.textColor = .black
        menuBarItemLabel.font = UIFont(name: K.Assets.Fonts.HindSiliguri.medium, size: 17)
        return menuBarItemLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? K.Assets.Colors.orange : .black
            print("Label tapped")
        }
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? K.Assets.Colors.orange : .black
            print("Label tapped")

        }
    }
}
