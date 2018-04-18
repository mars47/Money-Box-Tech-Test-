//
//  Result.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 06/04/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case POSTlogin
    case GETaccountdata
    case POSToneoffpayments
    case POSTlogout
}
extension Endpoint {
    var endpoint: String {
        switch self {
        case .POSTlogin: return "/users/login"
        case .GETaccountdata: return "/investorproduct/thisweek"
        case .POSToneoffpayments: return "/oneoffpayments"
        case .POSTlogout: return "/users/logout"
        }
    }
}

enum RequestType {
    case GET
    case POST
}
