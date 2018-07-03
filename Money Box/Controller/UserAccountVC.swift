//
//  UserAccountVC.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 26/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class UserAccountVC: UIViewController {
    
    let networkManager = NetworkManager()
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
 
            if var user = self.user {
                
                networkManager.downloadAccountData(bearerToken: user.bearerToken) { (product : [Dictionary <String, Any>]) -> () in
    
                user.ISA = ISA(initWithDictionary: product[0])
                user.GIA = GIA(initWithDictionary: product[1])
                self.user = user
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func isaButtonPressed(_ sender: Any) {
        if let user = self.user {
          self.performSegue(withIdentifier: "isa", sender: user)
        }
    }

    @IBAction func giaButtonPressed(_ sender: Any) {
        if let user = self.user {
            self.performSegue(withIdentifier: "gia", sender: user)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if let destination = segue.destination as? StocksSharesVC {
            if let user = sender as? User {
                destination.user = user
            }
        }
        
        if let destination = segue.destination as? GeneralInvestmentVC {
            if let user = sender as? User {
                destination.user = user
            }
        }
    
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        networkManager.logout(bearerToken: (user?.bearerToken)!)
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
}

