//
//  ActivitiesTableViewCell.swift
//  Cookin
//
//  Created by Owen Medina on 12/30/20.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
