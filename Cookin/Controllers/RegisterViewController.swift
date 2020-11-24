//
//  RegisterViewController.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/18/20.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameValidationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    var textFieldsWithLabels = [(textField: UITextField, label: UILabel)]()
    var textFields = [UITextField]()
    var validator = Validator()
    var firebaseAuthManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add text fields
        textFieldsWithLabels.append((textField: nameTextField, label: nameValidationLabel))
        textFieldsWithLabels.append((textField: emailTextField, label: emailValidationLabel))
        textFieldsWithLabels.append((textField: passwordTextField, label: passwordValidationLabel))
        textFields.append(nameTextField)
        textFields.append(emailTextField)
        textFields.append(passwordTextField)
        
        // Setup UI
        
        // Password Text Field
        passwordTextField.isSecureTextEntry = true
        // Register Button
        registerButton.titleLabel?.minimumScaleFactor = 0.7
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        registerButton.layer.borderWidth = K.buttonBorderWidth
        registerButton.layer.borderColor = K.orange.cgColor
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
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
    }

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        var hasInvalidFields = false
        let results = validator.validateTextFields(textFields)
        for (result, textFieldAndLabel) in zip(results, textFieldsWithLabels) {
            textFieldAndLabel.label.text = result.message
            UIView.animate(withDuration: K.standardAnimationDuration) {
                textFieldAndLabel.label.isHidden = result.valid
            }
            if !result.valid {
                hasInvalidFields = true
            }
        }
        if !hasInvalidFields {
            firebaseAuthManager.registerUser(withEmail: emailTextField.text!, name: nameTextField.text!, password: passwordTextField.text!)
        }
    }
}

//MARK: - UITextFieldDelegate Methods
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let result = validator.validateTextField(textField)
        switch textField.accessibilityIdentifier {
        case K.Accessibility.nameTextFieldIdentifier:
            nameValidationLabel.text = result.message
            UIView.animate(withDuration: K.standardAnimationDuration) {
                self.nameValidationLabel.isHidden = result.valid
            }
            if result.valid {
                emailTextField.becomeFirstResponder()
            }
        case K.Accessibility.emailTextFieldIdentifier:
            emailValidationLabel.text = result.message
            UIView.animate(withDuration: K.standardAnimationDuration) {
                self.emailValidationLabel.isHidden = result.valid
            }
            if result.valid {
                passwordTextField.becomeFirstResponder()
            }
        case K.Accessibility.passwordTextFieldIdentifier:
            passwordValidationLabel.text = result.message
            UIView.animate(withDuration: K.standardAnimationDuration) {
                self.passwordValidationLabel.isHidden = result.valid
            }
            if result.valid {
                textField.resignFirstResponder()
            }
        default:
            if result.valid {
                textField.resignFirstResponder()
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // after the validation label is shown and once editing has begun, hide the label
        switch textField.accessibilityIdentifier {
        case K.Accessibility.nameTextFieldIdentifier:
            UIView.animate(withDuration: K.standardAnimationDuration) {
                self.nameValidationLabel.isHidden = true
            }
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
extension RegisterViewController: FirebaseAuthManagerDelegate {
    func didSignIn(_ firebaseAuthManager: FirebaseAuthManager) {
        print("Successful sign in!")
        performSegue(withIdentifier: K.registerToHome, sender: self)
    }
    
    func didFailWithError(_ error: AuthErrorCode?) {
        guard let authErrorCode = error else {
            // Present alert using unknown error
            infoAlert(message: K.Firebase.Auth.Error.unknownError)
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
        print("Error occurred on Register screen: \(error)")
    }
}
