//
//  ViewController.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 26/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = usernameTextField.username
        passwordTextField.text = passwordTextField.password
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        if let username = usernameTextField.text {
            if let password = passwordTextField.text {
                Network.sharedSessionManager.LoginRequest(username: username, password: password) { (state : Bool) -> Void in
          
                    if state == true {

                    }
                    else {
                        
                    }

                }
            }
        }
       
    }
    
}


