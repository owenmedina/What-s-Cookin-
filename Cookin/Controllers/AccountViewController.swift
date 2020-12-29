//
//  AccountViewController.swift
//  Cookin
//
//  Created by Owen Medina on 12/28/20.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var recipesCreatedCardView: CardView!
    @IBOutlet weak var recipesAuthoredCardView: CardView!
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup current user
        currentUser = (tabBarController as! CookinTabBarController).currentUser

        // Setup UI
            // User Image View
        userImageView.addCircularBorder(borderWidth: 5.0, borderColor: K.Assets.Colors.orange.cgColor)
            // User Name Label
        userNameLabel.text = currentUser?.name
            // Recipes Created Card View
        recipesCreatedCardView.cornerRadius = K.ShadowRoundedView.standardCornerRadius
            // Recipes Authored Card View
        recipesAuthoredCardView.cornerRadius = K.ShadowRoundedView.standardCornerRadius
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensure the User Image View remainds circular
        userImageView.addCircularBorder(borderWidth: 5.0, borderColor: K.Assets.Colors.orange.cgColor)
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
