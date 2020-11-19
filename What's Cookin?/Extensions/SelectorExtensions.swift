//
//  SelectorExtensions.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/18/20.
//

import Foundation
import UIKit

internal extension Selector {
    static let keyboardWillShow = #selector(UIViewController.keyboardWillShow(notification:))
    static let keyboardWillHide = #selector(UIViewController.keyboardWillHide(notification:))
}
