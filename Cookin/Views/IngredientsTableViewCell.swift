//
//  IngredientsTableViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkBoxTapped(_ sender: CheckBox) {
        // Note: Method is called before isChecked is changed
        // Ergo, the new value will still be opposite of what it is now
        if sender.isChecked {
            ingredientLabel.textColor = .black
            ingredientLabel.removeStrikeThroughOnText()
        } else {
            ingredientLabel.textColor = K.Assets.Colors.orange
            ingredientLabel.strikeThroughText()
        }
    }
}
