//
//  GeneralInvestmentVC.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 29/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class GeneralInvestmentVC: UIViewController {
    let networkManager = NetworkManager()
    var user: User?
    @IBOutlet weak var accountBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            accountBalance.text = "£" + String(user.GIA.moneyBox)
        }
    }
    
    @IBAction func paymentButtonPressed(_ sender: Any) {
        
        guard let user = user else {return}
        networkManager.makeOneOfPayment(amount: 10, productID: user.GIA.investorProductId, bearerToken: user.bearerToken) { (result : [String: Int]) -> () in
            
            if let money =  result["Moneybox"] {
                DispatchQueue.main.async {
                    self.accountBalance.text = "£" + String(money)
                }
            }
        }
    }
    
}
