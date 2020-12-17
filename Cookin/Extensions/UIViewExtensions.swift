//
//  UIViewExtensions.swift
//  Cookin
//
//  Created by Owen Medina on 12/17/20.
//

import UIKit

extension UIView {
    // Constrains subview to its superview (i.e. pins subview's edges to the superview's edges)
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error in UIView.bindFrameToSuperViewBounds: \(K.Error.cannotBindViewFrameToSuperviewFrame)")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        
    }
}
