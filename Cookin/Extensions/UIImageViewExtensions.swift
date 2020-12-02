//
//  UIImageViewExtensions.swift
//  Cookin
//
//  Created by Owen Medina on 11/26/20.
//

import Foundation
import UIKit

extension UIImageView {
    func addPartialSemiTransparentOverlay(usingBoundsOf superview: UIView?, transparencyLevel: CGFloat = K.Transparency.semiTransparent) {
        // Add a semi-transparent overlay that covers only part of the image view
        // Must have a superview that the UIImageView pins its edges to (i.e. superview and image view are exact same size and position)
        if let superview = superview {
            let gradient = CAGradientLayer()
            gradient.frame = superview.bounds
            gradient.colors = [UIColor.black.withAlphaComponent(transparencyLevel).cgColor, UIColor.clear.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
            self.layer.addSublayer(gradient)
        }
        
    }
    
//    open override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        if let partialSemiTransparentOverlay = self.layer.sublayers?.first, let superview = self.superview {
//            partialSemiTransparentOverlay.frame = superview.bounds
//        }
//        
//    }
}
