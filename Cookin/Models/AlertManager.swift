//
//  AlertManager.swift
//  Cookin
//
//  Created by Owen Medina on 11/23/20.
//

import Foundation
import UIKit

struct AlertManager {
    func infoAlert(message: String, image: UIImage?, title: String = K.Alert.funnyErrorTitle) -> AlertViewController {
        let alert = UIStoryboard(name: K.Storyboard.alert, bundle: .main)
        let alertViewController = alert.instantiateViewController(withIdentifier: K.Storyboard.alertViewController) as! AlertViewController
        
        return alertViewController
    }
}
