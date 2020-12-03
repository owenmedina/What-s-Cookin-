//
//  RecipeViewController.swift
//  Cookin
//
//  Created by Owen Medina on 12/2/20.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        label.text = recipe?.cuisine.rawValue.uppercased()
        self.navigationItem.title = recipe?.title
    }
    
    
}
