//
//  CheckBox.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

class CheckBox: UIButton {
    let checkedImage = #imageLiteral(resourceName: "checked-box")
    let uncheckedImage = #imageLiteral(resourceName: "unchecked-box")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: Selector.checkBoxTapped, for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    // Objective-C Methods
    @objc func checkBoxTapped(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    
}
