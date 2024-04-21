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
    
    var authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authManager.addObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        authManager.removeObserver(self)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        errorLabel.text = ""
        
        let emailError = emailField.errorEmptyCheck(field: emailField, name: "email")
        let passwordError = passwordField.errorEmptyCheck(field: passwordField, name: "password")
        
        if emailError.error != true, passwordError.error != true {
            authManager.login(email: emailField.text!, password: passwordField.text!)
        } else {
            errorLabel.text = ErrorManager.getCombinedErrorMessages(errorFields: [emailError, passwordError])
        }
    }
}


// MARK: - AuthObserver

extension LoginViewController: AuthObserver {
    
    func loginDidFinish(response: AuthResponse) {
        if response.error.error {
            errorLabel.text = response.error.message
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: K.Segue_LoginToChat_ID, sender: self)
            }
        }
    }
    
}

