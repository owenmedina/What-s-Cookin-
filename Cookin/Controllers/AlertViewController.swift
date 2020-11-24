//
//  AlertViewController.swift
//  Cookin
//
//  Created by Owen Medina on 11/23/20.
//

import UIKit

class AlertViewController: UIViewController {
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }

    @IBAction func actionButtonTapped(_ sender: UIButton) {
    }
}
