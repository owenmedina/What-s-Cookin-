//
//  UIImageViewExtensions.swift
//  Cookin
//
//  Created by Owen Medina on 11/26/20.
//

import Foundation
import UIKit

extension UIImageView {
    func addPartialSemiTransparentOverlay() {
        // Add a semi-transparent overlay that covers only part of the image view
        // Must have a superview that the UIImageView pins its edges to (i.e. superview and image view are exact same size and position)
        if let superview = self.superview {
            let gradient = CAGradientLayer()
            gradient.frame = superview.bounds
            gradient.colors = [UIColor.black.withAlphaComponent(K.Transparency.semiTransparent).cgColor, UIColor.clear.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
            self.layer.addSublayer(gradient)
        }
    }
    
    private func updateGradientLayer() {
        if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.frame
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.5)
        }
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        //updateGradientLayer()
    }
}
