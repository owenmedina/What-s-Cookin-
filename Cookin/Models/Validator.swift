//
//  Validator.swift
//  Cookin
//
//  Created by Owen Medina on 11/19/20.
//

import Foundation
import UIKit

struct Validator {
    func validateRequiredField(_ textField: UITextField) -> (Bool, String?) {
        let emptyWarning = "\(textField.accessibilityLabel ?? "Field") \(K.Error.emptyTextField)"
        guard let text = textField.text else {
            return (false, emptyWarning)
        }
        
        if text.count > 0 {
            return (true, nil)
        }
        return (false, emptyWarning)
        
    }
    
    func validateEmail(_ textField: UITextField) -> (Bool, String?) {
        return validate(textField, matching: K.emailRegex, with: K.Error.invalidEmail)
    }
    
    func validatePassword(_ textField: UITextField) -> (Bool, String?) {
        return validate(textField, matching: K.passwordRegex, with: K.Error.invalidPassword)
        
    }
    
    func validate(_ textField: UITextField, matching regex: String, with warning: String) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, "\(textField.accessibilityLabel ?? "Field") \(K.Error.emptyTextField)")
        }
        let valid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
        if valid {
            return (valid, nil)
        } else {
            return (valid, warning)
        }
    }
    
    func validateTextField(_ textField: UITextField) -> (valid: Bool, message: String?) {
        switch textField.accessibilityIdentifier {
        case K.Accessibility.emailTextFieldIdentifier:
            return validateEmail(textField)
        case K.Accessibility.passwordTextFieldIdentifier:
            return validatePassword(textField)
        default:
            return validateRequiredField(textField)
        }
    }
    
    
    func validateTextFields(_ textFields: [UITextField]) -> [(valid: Bool, message: String?)] {
        var results = [(Bool, String?)]()
        for textField in textFields {
            switch textField.accessibilityIdentifier {
            case K.Accessibility.emailTextFieldIdentifier:
                results.append(validateEmail(textField))
            case K.Accessibility.passwordTextFieldIdentifier:
                results.append(validatePassword(textField))
            default:
                results.append(validateRequiredField(textField))
            }
        }
        return results
    }
}
