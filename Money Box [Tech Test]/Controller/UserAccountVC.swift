//
//  UserAccountVC.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 26/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class UserAccountVC: UIViewController {
    

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        Network.sharedSessionManager.downloadAccountData() { (product : [Dictionary <String, Any>]) -> () in

            if var user = self.user {
                
                user.ISA = ISA(initWithDictionary: product[0])
                user.GIA = GIA(initWithDictionary: product[1])
            }
        }
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
    
}

