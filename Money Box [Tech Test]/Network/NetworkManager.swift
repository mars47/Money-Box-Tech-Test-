//
//  NetworkManager.swift
//  Money Box [Tech Test]
//
//  Created by Omar  on 06/04/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation

class NetworkManager {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func LoginRequest(username: String, password: String, completion: @escaping ([String : Any], Int, String) -> Void) {
        
        let parameters = ["Email": "\(username)", "Password": "\(password)", "Idfa": "the idfa of the ios device"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        let request = Request(withPath:Endpoint.POSTlogin.endpoint)
        request.request = request.addHttpBody(body: httpBody)
        request.request = request.addRequestType(type: .POST)
        guard let completeRequest = request.request else { return }
        

        self.session.dataTask(with: completeRequest) { (data, response, error ) in
            
            // Decides whether or not the user has logged in based on the returned http status code
            if let httpresponse = response as? HTTPURLResponse {
                if (httpresponse.statusCode == 200) {
                    if let data = data {
                        do {
                            let root = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                            if let jsonDict = root["User"] as? [String: Any] {
                            completion(jsonDict, httpresponse.statusCode, request.getBearerToken(data: data))
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }.resume()
    }
    
    func downloadAccountData(bearerToken: String, completion: @escaping ([Dictionary <String, Any>]) -> ()) {
        
        let request = Request(withPath:Endpoint.GETaccountdata.endpoint)
        
        request.request = request.addRequestType(type: .GET); request.bearerToken = bearerToken
        request.setRequest()
        self.session.dataTask(with: request.request!) { (data, response, error) in
            
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
        }.resume()
        
    }
    
    
    func makeOneOfPayment(amount: Int, productID: Int, bearerToken: String, completion: @escaping ([String: Int]) -> ()) {
        let request = Request(withPath:Endpoint.POSToneoffpayments.endpoint)
        let parameters: [String: String] = ["Amount": "\(amount)",
            "InvestorProductId": "\(productID)"]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.bearerToken = bearerToken; request.setRequest()
        request.request = request.addHttpBody(body: httpBody)
        request.request = request.addRequestType(type: .POST);
        
        self.session.dataTask(with: request.request!) { (data, response, error ) in
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
    
    func logout(bearerToken: String) -> () {
         let request = Request(withPath:Endpoint.POSTlogout.endpoint)
        
            request.bearerToken = bearerToken; request.setRequest()
            request.request = request.addRequestType(type: .POST);

            session.dataTask(with: request.request!) { (data, response, error ) in
                
                if let repsonse = response {
                    print(repsonse)
                }
                }.resume()
    }

}
