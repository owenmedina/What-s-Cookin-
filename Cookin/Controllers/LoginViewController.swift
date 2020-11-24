//
//  LoginViewController.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/18/20.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    var textFieldsWithLabels = [(textField: UITextField, label: UILabel)]()
    var textFields = [UITextField]()
    var validator = Validator()
    var firebaseAuthManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add text fields
        textFieldsWithLabels.append((textField: emailTextField, label: emailValidationLabel))
        textFieldsWithLabels.append((textField: passwordTextField, label: passwordValidationLabel))
        textFields.append(emailTextField)
        textFields.append(passwordTextField)
        
        // Setup UI
        
        // Password Text Field
        passwordTextField.isSecureTextEntry = true
        // Login Button
        loginButton.titleLabel?.minimumScaleFactor = 0.7
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        loginButton.layer.borderWidth = K.buttonBorderWidth
        loginButton.layer.borderColor = K.orange.cgColor
        // Register self for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: .keyboardWillShow, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: .keyboardWillHide, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Setup delegates
        for textField in textFields {
            textField.delegate = self
        }
        firebaseAuthManager.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop receiving keyboard notifications
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensures buttons stay circular even if view is re-drawn and frame sizes are re-calculated
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        var hasInvalidFields = false
        let results = validator.validateTextFields(textFields)
        for (result, textFieldAndLabel) in zip(results, textFieldsWithLabels) {
            if textFieldAndLabel.textField.accessibilityIdentifier == K.Accessibility.passwordTextFieldIdentifier {
                continue
            }
            textFieldAndLabel.label.text = result.message
            UIView.animate(withDuration: K.standardAnimationDuration) {
                textFieldAndLabel.label.isHidden = result.valid
            }
            if !result.valid {
                hasInvalidFields = true
            }
        }
        
        if !hasInvalidFields {
            firebaseAuthManager.loginUser(withEmail: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    //    fileprivate func validateTextField(_ textField: UITextField) {
    //        switch textField {
    //        case emailTextField:
    //            let (valid, warning) = validator.validateEmail(textField)
    //            if valid {
    //                passwordTextField.becomeFirstResponder()
    //            }
    //            emailValidationLabel.text = warning
    //            UIView.animate(withDuration: K.standardAnimationDuration, animations: {
    //                self.emailValidationLabel.isHidden = valid
    //            })
    //        case passwordTextField:
    //            let (valid, warning) = validator.validatePassword(textField)
    //            passwordValidationLabel.text = warning
    //            UIView.animate(withDuration: K.standardAnimationDuration) {
    //                self.passwordValidationLabel.isHidden = valid
    //            }
    //            if valid {
    //                fallthrough
    //            }
    //        default:
    //            textField.resignFirstResponder()
    //        }
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//MARK: - UITextFieldDelegate Methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.accessibilityIdentifier {
        case K.Accessibility.emailTextFieldIdentifier:
            let result = validator.validateTextField(textField)
            emailValidationLabel.text = result.message
            UIView.animate(withDuration: K.standardAnimationDuration) {
                self.emailValidationLabel.isHidden = result.valid
            }
            if result.valid {
                passwordTextField.becomeFirstResponder()
            }
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // after the validation label is shown and once editing has begun, hide the label
        switch textField.accessibilityIdentifier {
        case K.Accessibility.emailTextFieldIdentifier:
            UIView.animate(withDuration: K.standardAnimationDuration) {
                self.emailValidationLabel.isHidden = true
            }
        case K.Accessibility.passwordTextFieldIdentifier:
            UIView.animate(withDuration: K.standardAnimationDuration) {
                self.passwordValidationLabel.isHidden = true
            }
        default:
            break
        }
            
            
        return true
    }
    
}

//MARK: - FirebaseAuthManagerDelegate Methods
extension LoginViewController: FirebaseAuthManagerDelegate {
    func didSignIn(_ firebaseAuthManager: FirebaseAuthManager) {
        performSegue(withIdentifier: K.loginToHome, sender: self)
    }
    
    func didFailWithError(_ error: AuthErrorCode?) {
        guard let authErrorCode = error else {
            // Present alert using unknown error
            infoAlert(message: K.Firebase.Auth.Error.unknownError, title: K.Alert.error)
            return
        }
        switch authErrorCode {
        case .invalidEmail:
            emailValidationLabel.text = K.Firebase.Auth.Error.invalidEmail
            UIView.animate(withDuration: 0) {
                self.emailValidationLabel.isHidden = false
            }
            return
        case .wrongPassword:
            passwordValidationLabel.text = K.Firebase.Auth.Error.wrongPassword
            UIView.animate(withDuration: 0) {
                self.passwordValidationLabel.isHidden = false
            }
            return
        default:
            break
        }
        // Present an alert with error
        infoAlert(message: authErrorCode.message)
        print("Error occurred on Login screen: \(error)")
    }
}
