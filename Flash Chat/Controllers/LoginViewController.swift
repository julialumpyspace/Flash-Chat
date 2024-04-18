//
//  ViewController.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 17.04.2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        errorLabel.text = ""
        
        let emailError = emailField.errorEmptyCheck(field: emailField, name: "email")
        let passwordError = passwordField.errorEmptyCheck(field: passwordField, name: "password")
        
        if emailError.error != true, passwordError.error != true {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
                if error != nil {
                    self.errorLabel.text = error?.localizedDescription
                } else {
                    self.performSegue(withIdentifier: K.Segue_LoginToChat_ID, sender: self)
                }
            }
        } else {
            errorLabel.text = ErrorManager.getCombinedErrorMessages(errorFields: [emailError, passwordError])
        }
    }
    
}

