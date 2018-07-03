//
//  CustomButton.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 30/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var myValue: Int
    
    required init?(coder aDecoder: NSCoder) {
        // set myValue before super.init is called
        self.myValue = 0
        
        super.init(coder: aDecoder)
        
        // set other operations after super.init, if required
        self.layer.cornerRadius = 8 // 5
        self.layer.borderWidth = 2 // 1
        self.layer.borderColor = UIColor.white.cgColor
    }

}


