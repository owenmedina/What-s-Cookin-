//
//  RecipeCollectionViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 11/30/20.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell, ShadowedRoundedView {
    @IBOutlet weak var titleLabel: UILabel!

    @IBInspectable var cornerRadius: CGFloat = K.ShadowRoundedView.standardCornerRadius {
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
