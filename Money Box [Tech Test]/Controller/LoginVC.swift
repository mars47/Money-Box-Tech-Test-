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
                        DispatchQueue.main.async{
                        self.performSegue(withIdentifier: "show", sender: nil)
                        }
                    }
                    if state == false {
                        DispatchQueue.main.async{
                        self.displayAlertMessage(message: "You have entered Incorrect Details")
                        }
                    }

                }
            }
        }
       
    }
    
    func displayAlertMessage(message: String) {
        
        let alert = UIAlertController(title: "Please Try Again", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.default, handler:nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}


