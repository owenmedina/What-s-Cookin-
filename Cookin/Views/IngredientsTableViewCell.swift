//
//  IngredientsTableViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientCheckBox: CheckBox!
    var ingredient: Ingredient?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func checkBoxTapped(_ sender: CheckBox) {
        if ingredient != nil {
            ingredient!.checked = !ingredient!.checked
            if ingredient!.checked {
                ingredientLabel.textColor = K.Assets.Colors.orange
                ingredientLabel.strikeThroughText()
            } else {
                ingredientLabel.textColor = .black
                ingredientLabel.removeStrikeThroughOnText()
            }
        }
    }
    
//    func resetLabel() {
//        ingredientLabel.textColor = .black
//        ingredientLabel.removeStrikeThroughOnText()
//    }
}
