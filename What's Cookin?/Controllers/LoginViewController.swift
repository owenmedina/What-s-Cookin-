//
//  LoginViewController.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/18/20.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI
        
        // Email Text Field
        let emailUnderline = CALayer()
        emailUnderline.frame = CGRect(origin: CGPoint(x: 0, y: emailTextField.frame.height - 1), size: CGSize(width: emailTextField.frame.width, height:  1))
        emailUnderline.backgroundColor = UIColor.lightGray.cgColor
        emailTextField.borderStyle = .none
        emailTextField.layer.addSublayer(emailUnderline)
        // Password Text Field
        passwordTextField.isSecureTextEntry = true
        let passwordUnderline = CALayer()
        passwordUnderline.frame = CGRect(origin: CGPoint(x: 0, y: emailTextField.frame.height - 1), size: CGSize(width: emailTextField.frame.width, height:  1))
        passwordUnderline.backgroundColor = UIColor.lightGray.cgColor
        passwordTextField.borderStyle = .none
        passwordTextField.layer.addSublayer(passwordUnderline)
        // Login Button
        loginButton.titleLabel?.minimumScaleFactor = 0.7
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        loginButton.layer.borderWidth = K.buttonBorderWidth
        loginButton.layer.borderColor = K.orange.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensures fields and buttons stay circular even if view is re-drawn and frame sizes are re-calculated
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        emailTextField.layer.cornerRadius = emailTextField.frame.size.height/2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height/2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
