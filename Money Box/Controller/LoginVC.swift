//
//  ViewController.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 26/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//  https://github.com/MoneyBox/ios-technical-task

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

       let networkManager = NetworkManager()
        networkManager.LoginRequest(username: usernameTextField.text!, password: passwordTextField.text!) { jsonDict, httpStatusCode, bearerToken in
            
            if httpStatusCode == 200 {
                var user = User(initWithDictionary: jsonDict)
                user.bearerToken = bearerToken
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "show", sender: user)
                }
            }
            
            if httpStatusCode != 200 {
                DispatchQueue.main.async{
                    self.displayAlertMessage(message: "You have entered Incorrect Details")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if let destination = segue.destination as? UserAccountVC {
            if let user = sender as? User {
                destination.user = user
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}


