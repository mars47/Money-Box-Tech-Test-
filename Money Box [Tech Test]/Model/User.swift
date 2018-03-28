//
//  User.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 27/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

struct User: Codable {
    var Email: String
    var Password: String
    var Idfa: String?
}



/* Prints:
 {
 "name" : "Pear",
 "points" : 250,
 "description" : "A ripe pear."
 }
 */
