//
//  SignUpViewController.swift
//  CustomLoginPage
//
//  Created by rd on 21/07/21.
//  Copyright © 2021 vishnu. All rights reserved.
//

import UIKit
import FirebaseAuth
import  Firebase

class SignUpViewController: UIViewController {
    
    
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
    
    func setUpElements(){
        //Hide the error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
        }
    
    func validateFields()->String?{
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields "
        }
            //check if the password is secure
        let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
       
        if Utilities.isPasswordValid(cleanedPassword!) == false{
            //password isn't secured
            return "Please make sure your password is atleast 8 characters, contains a special character and a number."
            
        }
        
        return nil
    }


    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        //validate fields
        let error = validateFields()
        
        func showError(_ message:String) {
            errorLabel.text = message
            errorLabel.alpha = 1
        }

        
        if error != nil {
            //there's comething wrong with the fields,show error message
           showError(error!)
        }
        else{
            
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil {
                    
                    //there was error creating the user
                    showError("error creating user")
            }
                else{
                    //user was created succesfully, now store the firstname and lastname
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstname,"lastname":lastname,"uid":result!.user.uid], completion: { (error) in
                        if error != nil {
                            //show error message
                            showError("error saving user data")
                        }
                    })
                    
                }
            
            //transition to the home screen
                self.transitionToHome()
        }
    }
}

func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
