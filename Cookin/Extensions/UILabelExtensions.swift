//
//  UILabelExtensions.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

extension UILabel {
    func strikeThroughText() {
        let attributedString =  NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    func removeStrikeThroughOnText() {
        let text = self.text
        self.attributedText = nil
        self.text = nil
        self.text = text
    }
}
