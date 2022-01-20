//
//  SignUpController.swift
//  BasicLoginPage
//
//  Created by Vansh Maheshwari on 20/01/22.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    
    func validateFields() -> String? {
        
        //check all filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in the fields."
        }
        
        //if password is secure
        let cleanPass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPass) == false {
            return "Please check if password is at least 8 characters, contains a number and a special character."
        }
        
        return nil
    }

    @IBAction func signUpTap(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            //show error message
            errorDisplay(error!)
        }
        else {
            
            Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>) { (result, err) in
                
                //check errors
                if err != nil {
                    //there was error
                    errorDisplay("Error creating user")
                }
                
                else {
                    //successful user creation
                    Firestore.firestore()
                }
                
            }
            
        }
        
        func errorDisplay(_ text:String) {
            errorLabel.text = text
            errorLabel.alpha = 1
        }
        
        
    }
    
    
}
