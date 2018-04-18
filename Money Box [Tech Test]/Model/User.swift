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
   private var _bearerToken: String!

    var firstName: String {
        return _firstName
    }
    var lastName: String {
        return _lastName
    }
    var email: String {
        return _email
    }
    var GIA: GIA {
        get {
            return _GIA_Account
        }
        set {
            _GIA_Account = newValue
        }
    }
    var ISA: ISA {
        get {
            return _ISA_Account
        }
        set {
            _ISA_Account = newValue
        }
    }
    
    var bearerToken: String {
        get {
            return _bearerToken
        }
        set {
            _bearerToken = newValue
        }
    }
    init(initWithDictionary dict: [String: Any]) {
        
        _firstName = dict["FirstName"] as! String
        _lastName = dict["LastName"] as! String
        _email = dict["Email"] as! String
        
    }
}
