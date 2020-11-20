//
//  UnderlineTextField.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/19/20.
//

import UIKit

class UnderlineTextField: UITextField {
    open override func awakeFromNib() {
        //MARK: Setup Bottom-Border
        var bottomBorder = UIView()
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        //Mark: Setup Anchors
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        self.borderStyle = .none
        super.awakeFromNib()
    }
}
