//
//  RegisterViewController.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/18/20.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI
        
        // Name Text Field
        let nameUnderline = CALayer()
        nameUnderline.frame = CGRect(origin: CGPoint(x: 0, y: nameTextField.frame.height - 1), size: CGSize(width: nameTextField.frame.width, height:  1))
        nameUnderline.backgroundColor = UIColor.lightGray.cgColor
        nameTextField.borderStyle = .none
        nameTextField.layer.addSublayer(nameUnderline)
        // Email Text Field
        let emailUnderline = CALayer()
        emailUnderline.frame = CGRect(origin: CGPoint(x: 0, y: emailTextField.frame.height - 1), size: CGSize(width: emailTextField.frame.width, height:  1))
        emailUnderline.backgroundColor = UIColor.lightGray.cgColor
        emailTextField.borderStyle = .none
        emailTextField.layer.addSublayer(emailUnderline)
        // Password Text Field
        passwordTextField.isSecureTextEntry = true
        let passwordUnderline = CALayer()
        passwordUnderline.frame = CGRect(origin: CGPoint(x: 0, y: passwordTextField.frame.height - 1), size: CGSize(width: passwordTextField.frame.width, height:  1))
        passwordUnderline.backgroundColor = UIColor.lightGray.cgColor
        passwordTextField.borderStyle = .none
        passwordTextField.layer.addSublayer(passwordUnderline)
        // Login Button
        registerButton.titleLabel?.minimumScaleFactor = 0.7
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        registerButton.layer.borderWidth = K.buttonBorderWidth
        registerButton.layer.borderColor = K.orange.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensures buttons stay circular even if view is re-drawn and frame sizes are re-calculated
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
    }

}
