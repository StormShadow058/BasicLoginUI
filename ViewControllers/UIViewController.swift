//
//  UIViewController.swift
//  BasicLoginPage
//
//  Created by Vansh Maheshwari on 20/01/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
        
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signupButton)
        Utilities.styleHollowButton(loginButton)
    }


}
