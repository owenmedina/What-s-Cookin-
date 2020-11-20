//
//  ViewControllerExtensions.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/18/20.
//

import Foundation
import UIKit

//MARK: - Keyboard Methods
internal extension UIViewController {
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            print("UIViewController.keyboardWillShow(): User Info is nil")
            return
        }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            print("UIViewController.keyboardWillShow(): Could not retrive keyboardFrameEnd or cast it to NSValue")
            return
        }
        
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height/2
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
