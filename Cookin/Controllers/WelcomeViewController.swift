//
//  ViewController.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/16/20.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Setup UI
        
        // Register Button
        registerButton.titleLabel?.minimumScaleFactor = 0.7 
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        registerButton.backgroundColor = K.Assets.Colors.red
        // Login Button
        loginButton.titleLabel?.minimumScaleFactor = 0.7
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        loginButton.layer.borderWidth = K.buttonBorderWidth
        loginButton.layer.borderColor = K.Assets.Colors.orange.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensures buttons stay circular even if view is re-drawn and frame sizes are re-calculated
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
    }


}

