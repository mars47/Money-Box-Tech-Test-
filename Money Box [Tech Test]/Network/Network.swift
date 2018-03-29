//
//  Network.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 27/03/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class Network: NSObject {
    
    static var sharedSessionManager = Network()
    var bearerToken: String?
    var authRequest: URLRequest?
    
    func LoginRequest (username: String, password: String, completion: @escaping (Bool) -> ()) {
        
        let parameters: [String: String] = ["Email": "\(username)",
            "Password": "\(password)",
            "Idfa": "the idfa of the ios device"]

        let request = makeURLRequestForLogin(parameters: parameters)
        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error ) in
            
            // Decides whether or not the user has logged in based on the returned http status code
            if let httpresponse = response as? HTTPURLResponse {
                if (httpresponse.statusCode > 199 && httpresponse.statusCode < 300) {
                    print("SUCCESS! USER IS LOGGED IN")
                    if let data = data {
                        
                        do {
                            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                            self.addBearerTokentoHeader(bearerToken: self.getBearerToken(from: jsonDict), initialRequest: request)
                            //print(jsonDict)
                            completion(true)
                        } catch {
                            print(error)
                            completion(false)
                        }
                    }
                    
                } else {
                    print("FAILED! USER COULD NOT LOG IN")
                    completion(false)
                }
            }

        }.resume()
    }
    
    func makeURLRequestForLogin(parameters: [String: String]) -> URLRequest {
 
        guard let url = URL(string: "https://api-test00.moneyboxapp.com/users/login") else {
            return URLRequest(url: URL(string: "")!)
        }
        var request: URLRequest = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("8cb2237d0679ca88db6464", forHTTPHeaderField: "AppId")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("4.0.0", forHTTPHeaderField: "appVersion")
        request.addValue("3.0.0", forHTTPHeaderField: "apiVersion")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return request }
        request.httpBody = httpBody
        
        print(String(data: httpBody, encoding: .utf8)!)
        return request
    }
    
    func getBearerToken(from: [String : Any]) -> String {
        
        if let session = from["Session"] as? [String: Any] {
            if let bearerToken = session["BearerToken"] as? String {
                print(" BEARER TOKEN: " + bearerToken)
                return bearerToken
            }
        }
        return "no token"
    }
    
    func addBearerTokentoHeader(bearerToken: String, initialRequest: URLRequest) {
        
        var request: URLRequest = initialRequest
        request.addValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")
        authRequest = request
    }
    
    func downloadAccountData() -> () {
          let url = URL(string: "https://api-test00.moneyboxapp.com/investorproduct/thisweek")
        if let request = authRequest {
            
            
        }
    }
}
