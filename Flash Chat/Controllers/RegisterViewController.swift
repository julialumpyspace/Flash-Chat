//
//  ViewController.swift
//  Flash Chat
//"
//  Created by Юлія Воробей on 17.04.2024.
//

import UIKit

class RegisterViewController: UIViewController {
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
    
    @IBAction func registerPressed(_ sender: UIButton) {
        errorLabel.text = ""
        
        let emailError = emailField.errorEmptyCheck(field: emailField, name: "email")
        let passwordError = passwordField.errorEmptyCheck(field: passwordField, name: "password")
        
        if !emailError.error, !passwordError.error {
            authManager.register(email: emailField.text!, password: passwordField.text!)
        } else {
            errorLabel.text = ErrorManager.getCombinedErrorMessages(errorFields: [emailError, passwordError])
        }
    }
}

// MARK: - AuthObserver

extension RegisterViewController: AuthObserver {
    
    func registrationDidFinish(response: AuthResponse) {
        if response.error.error {
            errorLabel.text = response.error.message
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: K.Segue_RegisterToChat_ID, sender: self)
            }
        }
    }
    
}



