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
    var completeHeader: URLRequest?
    
    func LoginRequest (username: String, password: String, completion: @escaping ([Any]) -> ()) {
        
        let parameters: [String: String] = ["Email": "\(username)",
            "Password": "\(password)",
            "Idfa": "the idfa of the ios device"]

        let request = makeURLRequestForLogin(parameters: parameters)
        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error ) in
            
            //all the variables i need returned in LoginVC, are appended to 'array'. the array is sent back on completion
            var array = [Any]()
            var bool = false

            // Decides whether or not the user has logged in based on the returned http status code
            if let httpresponse = response as? HTTPURLResponse {
                if (httpresponse.statusCode > 199 && httpresponse.statusCode < 300) {
                    print("SUCCESS! USER IS LOGGED IN")
                    if let data = data {
                        
                        do {
                            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                            self.addBearerTokentoHeader(bearerToken: self.getBearerToken(from: jsonDict), header: request)
                            //print(jsonDict)
                            bool = true
                            let userDict = jsonDict["User"] as! [String: Any]
                            array.append(userDict); array.append(bool)
                            completion(array)
                            
                        } catch {
                            print(error)
                            bool = false
                            array.append("failed"); array.append(bool)
                            completion(array)
                        }
                    }
                    
                } else {
                    print("FAILED")
                    array.append("failed"); array.append(bool)
                    completion(array)
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
    
    func addBearerTokentoHeader(bearerToken: String, header: URLRequest) {
        
        var request = header
        request.addValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")
        completeHeader = request
    }
    
    func downloadAccountData(completion: @escaping ([Dictionary <String, Any>]) -> ()) {
          let url = URL(string: "https://api-test00.moneyboxapp.com/investorproduct/thisweek")

        if var request = completeHeader {

            request.url = url; request.httpMethod = "GET"; request.httpBody = nil
            
            let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let data = data {
                    
                    do {
                        let root = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let array = root["Products"] as! [Dictionary <String, Any>]
                        //print(array)
                        completion(array)
         
                    } catch {
                        print(error)
                    }
                }
            }
            session.resume()
        }
    }
    
    func makeOneOfPayment(amount: Int, productID: Int, completion: @escaping ([String: Int]) -> ()) {
        
        if var request = completeHeader {
            
            request.url =  URL(string: "https://api-test00.moneyboxapp.com/oneoffpayments")
            let parameters: [String: String] = ["Amount": "\(amount)",
                "InvestorProductId": "\(productID)"]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error ) in
                
                if let data = data {
                    
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Int]
                        completion(jsonDict)
                        
                    } catch {
                        print(error)
                    }  
                }

            }.resume()
        }
    }
    
    func logout() -> () {
        
        if var request = completeHeader {
        request.url =  URL(string: "https://api-test00.moneyboxapp.com/users/logout")
        request.httpBody = nil
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error ) in
                
                if let repsonse = response {
                    print(repsonse)
                }
            }.resume()
        }
    }
}
