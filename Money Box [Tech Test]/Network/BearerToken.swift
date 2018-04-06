//
//  BearerToken.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 05/04/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class BearerToken: NSObject, Header {
  
    var base = "https://api-test00.moneyboxapp.com"
    var path: String
    var bearerToken = ""
    var requestType: String
    
    init(withPath path:String, requestType:String) {
       
        self.requestType = requestType
        self.path = path
        super.init()
    }

    func getBearerTokenForSession(from: [String : Any]) -> URLRequest {
        
        if let session = from["Session"] as? [String: Any] {
            if let bearerToken = session["BearerToken"] as? String {
                //print(" BEARER TOKEN: " + bearerToken)
                self.bearerToken = bearerToken
                return self.request
            }
        }
        return self.request
    }
    
    func addHttpBody(body: Data) -> URLRequest {
        var newrequest = self.request
        newrequest.httpBody = body
        return newrequest
        
    }
    
    func addRequestType(type: RequestType) -> URLRequest {
        var newRequest = self.request
                switch type {
                case .GET:
                    newRequest.httpMethod = "GET"
                case .POST:
                    newRequest.httpMethod = "POST"
                }
        return newRequest
    }

}


