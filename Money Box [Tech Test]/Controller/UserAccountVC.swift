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
        Network.sharedSessionManager.downloadAccountData()

    }
}

