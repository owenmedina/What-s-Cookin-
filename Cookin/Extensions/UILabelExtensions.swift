//
//  UILabelExtensions.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

extension UILabel {
    func strikeThroughText() {
        let attributeString =  NSMutableAttributedString(string: self.text ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        self.attributedText = attributeString
    }
    
    func removeStrikeThroughOnText() {
        let attributeString =  NSMutableAttributedString(string: self.text ?? "")
        self.attributedText = attributeString
    }
}
