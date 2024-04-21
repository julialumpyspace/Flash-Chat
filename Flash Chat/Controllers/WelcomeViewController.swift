//
//  ViewController.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 17.04.2024.
//

import UIKit
import CLTypingLabel

class WelсomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = K.AppTitleMessage
    }
}

