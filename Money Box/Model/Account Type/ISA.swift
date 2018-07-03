//
//  ISA.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 29/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation

struct ISA {
    
    private var _investorProductId: Int!
    private var _investorProductType: String!
    private var _moneyBox: Int!
    private var _planValue: Int!
    
    
    var investorProductId: Int {
        return _investorProductId
    }
    
    var investorProductType: String {
        return _investorProductType
    }
    
    var moneyBox: Int {
        return _moneyBox
    }
    
    var planValue: Int {
        return _planValue
    }
    
    
    
    init(initWithDictionary dict: [String: Any]) {
        
        _investorProductId = dict["InvestorProductId"] as! Int
        _investorProductType = dict["InvestorProductType"] as! String
        _moneyBox = dict["Moneybox"] as! Int
        _planValue = dict["PlanValue"] as! Int
        
    }
    
}
