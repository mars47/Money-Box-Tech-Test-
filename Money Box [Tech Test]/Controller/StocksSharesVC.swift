//
//  StocksSharesVC.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 26/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class StocksSharesVC: UIViewController {
    
    var user: User?
    @IBOutlet weak var accountBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            accountBalance.text = "£" + String(user.ISA.moneyBox)
        }
    }

    @IBAction func paymentButtonPressed(_ sender: Any) {
        
        guard let user = user else {return}
        Network.sharedSessionManager.makeOneOfPayment(amount: 10, productID: user.ISA.investorProductId) { (result : [String: Int]) -> () in
            
            if let money =  result["Moneybox"] {
                DispatchQueue.main.async {
                    self.accountBalance.text = "£" + String(money)
                }
            }
        }
    }
}
