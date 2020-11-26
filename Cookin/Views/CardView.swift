//
//  CardView.swift
//  Cookin
//
//  Created by Owen Medina on 11/24/20.
//

import UIKit

protocol ShadowedRoundedView {
    var cornerRadius: CGFloat { get set }
    var shadowColor: UIColor { get set }
    var shadowOffsetWidth: CGFloat { get set }
    var shadowOffsetHeight: CGFloat { get set }
    var shadowOpacity: Float { get set }
    var shadowRadius: CGFloat { get set }
    
    var shadowLayer: CAShapeLayer { get }
    
    func setCornerRadiusAndShadow()
}

extension ShadowedRoundedView where Self: UIView {
    func setCornerRadiusAndShadow() {
        layer.cornerRadius = cornerRadius
        shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: cornerRadius ).cgPath
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: shadowOffsetWidth ,
                                          height: shadowOffsetHeight )
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
    }
}

@IBDesignable
class CardView: UIView, ShadowedRoundedView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = K.standardShadowWidth {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    @IBInspectable var shadowOffsetHeight: CGFloat = K.standardShadowHeight {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    @IBInspectable var shadowOpacity: Float = K.standardShadowOpacity {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    @IBInspectable var shadowRadius: CGFloat = K.standardShadowRadius {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private(set) lazy var shadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        self.setNeedsLayout()
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCornerRadiusAndShadow()
    }
}

