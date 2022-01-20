//
//  SignUpController.swift
//  BasicLoginPage
//
//  Created by Vansh Maheshwari on 20/01/22.
//

import UIKit
import Firebase
import FirebaseFirestore
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
            
            //clean data
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                
                //check errors
                if err != nil {
                    //there was error
                    self.errorDisplay("Error creating user")
                }
                
                else {
                    //successful user creation
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": firstname, "lastname": lastname, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //error message
                            self.errorDisplay("User data couldn't be saved")
                        }
                    }
                    
                    //transition to home screen
                    self.homeTransit()
                    
                }
                
            }
            
        }
        
    }
    
    func errorDisplay(_ text:String) {
        errorLabel.text = text
        errorLabel.alpha = 1
    }
    
    func homeTransit() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomePageViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
}
