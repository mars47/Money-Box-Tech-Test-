//
//  User.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 29/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

struct User {
    
   private var _firstName: String!
   private var _lastName: String!
   private var _email: String!
   private var _GIA_Account: GIA!
   private var _ISA_Account: ISA!

    var firstName: String {
        return _firstName
    }
    var lastName: String {
        return _lastName
    }
    var email: String {
        return _email
    }
    var GIA_Account: GIA {
        return _GIA_Account
    }
    var ISA_Account: ISA {
        return _ISA_Account
    }
    
    init(initWithDictionary dict: [String: Any]) {
        
        _firstName = dict["FirstName"] as! String
        _lastName = dict["LastName"] as! String
        _email = dict["Email"] as! String
        
    }
}
