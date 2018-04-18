//
//  BearerToken.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 05/04/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class Request: NSObject, Header {
  
    var base = "https://api-test00.moneyboxapp.com"
    var path: String
    var bearerToken = ""
    var request : URLRequest?

    
    init(withPath path:String) {
       
        self.path = path
        super.init()
        setRequest()
    }

    func getBearerToken(data: Data) -> String {
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            if let session = jsonDict["Session"] as? [String: Any] {
                if let bearerToken = session["BearerToken"] as? String {
                    return bearerToken
                }
            }
        }
        catch{
            
        }
        return ""
    }
    
    func setRequest() {
        request = computedRequest //stores computed property permanently inside optional
    }
    
    func addHttpBody(body: Data) -> URLRequest {
        
        if var request = request {
        request.httpBody = body
        return request
        }
        else {
        setRequest()
        request?.httpBody = body
        return request!
        }
        
    }
    
    func addRequestType(type: RequestType) -> URLRequest {
        if var request = request {
            switch type {
            case .GET:
                request.httpMethod = "GET"
            case .POST:
                request.httpMethod = "POST"
            }
            return request
        }
        else {
            setRequest()
            
            switch type {
            case .GET:
                request!.httpMethod = "GET"
            case .POST:
                request!.httpMethod = "POST"
            }
            return request!
            
        }
    }

}


