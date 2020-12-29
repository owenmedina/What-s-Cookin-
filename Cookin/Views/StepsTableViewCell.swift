//
//  StepsTableViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

class StepsTableViewCell: UITableViewCell {
    @IBOutlet weak var stepLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
