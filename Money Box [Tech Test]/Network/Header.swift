//
//  EndpointProtocol.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 05/04/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation
protocol Header {
    var base: String { get }
    var path: String { get }
    var bearerToken: String { get }

    var requestType: String { get }

}
extension Header {

    var apiKey: String {
        return "api_key=34a92f7d77a168fdcd9a46ee1863edf1"
    }
    
    // this property composes url ready for 'request'
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    
    var request: URLRequest {
        
        get {
            let url = urlComponents.url! // .url contains full url with 'apiKey'
            print(url)
            var request = URLRequest(url: url)
            request.addValue("8cb2237d0679ca88db6464", forHTTPHeaderField: "AppId")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("4.0.0", forHTTPHeaderField: "appVersion")
            request.addValue("3.0.0", forHTTPHeaderField: "apiVersion")
            if bearerToken != "" {
                request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            }
            
            return request
        }
        
        set {
            request = newValue
        }
    }
}
//The whole point of this protocol is to prepare a URLRequest 

//This protocol has two required properties called “base” and “path” just like a regular endpoint, it also has a few computed properties in an extension, one is the APIKey required to be able to make the requestit also has a urlComponents property that will construct the url and finally the request that returns an URLRequest.
