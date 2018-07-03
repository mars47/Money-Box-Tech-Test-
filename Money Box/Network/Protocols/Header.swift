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

}
extension Header {
    
    // this property composes url ready for 'request'
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    
    var computedRequest: URLRequest {
        
            let url = urlComponents.url! // .url contains full url
            print(url)
            var computedRequest = URLRequest(url: url)
            computedRequest.addValue("8cb2237d0679ca88db6464", forHTTPHeaderField: "AppId")
            computedRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            computedRequest.addValue("4.0.0", forHTTPHeaderField: "appVersion")
            computedRequest.addValue("3.0.0", forHTTPHeaderField: "apiVersion")
            if bearerToken != "" {
                computedRequest.addValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")
            }
            return computedRequest
    }
}
//The whole point of this protocol is to prepare a URLRequest with the correct headers 

//This protocol has two required properties called “base” and “path” just like a regular endpoint, it also has a few computed properties in an extension, that will construct the url and finally the request that returns an URLRequest. As computeredRequest is a computed property it cannot be altered or stored, which is why a 'setRequest' function is used in the 'Request' class
