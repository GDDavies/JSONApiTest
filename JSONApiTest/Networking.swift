//
//  Networking.swift
//  JSONApiTest
//
//  Created by George Davies on 21/10/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit

typealias ServiceResponse = ([[String:Any]], Error?) -> Void

class NetworkingController: UIViewController {
    
    let baseURL = "http://localhost:3000/api/v1/"
    
    func getAllEntities(entityType: String) {
        let path = "\(baseURL)\(entityType)"
        makeHTTPGetRequest(path: path)
    }
    
    func deleteEntity(entityType: String, entityId: Int) {
        let path = "\(baseURL)\(entityType)/\(entityId)"
        
        // Make HTTP Delete request
        makeHTTPDeletetRequest(path: path)
    }
    
    // Not sure if working
    func updateEntity(entityType: String, entityId: Int, entity: User) {
        let path = "\(baseURL)\(entityType)/\(entityId)"
        
        if let dict = convertToJSON(data: entity) {
            do {
                if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                    makeHTTPPatchRequest(path: path, body: jsonData)
                }
            } catch {
                print("Couldn't convert to JSON")
            }
        }
    }
    
    func createNewEntity(entityType: String, entity: User) {
        let path = "\(baseURL)\(entityType)/"
        
        if let dict = convertToJSON(data: entity) {
            do {
                if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                    makeHTTPPostRequest(path: path, body: jsonData)
                    print(dict)
                }
            } catch {
                print("Couldn't convert to JSON")
            }
        }
    }
    
    fileprivate func makeHTTPGetRequest(path: String) {
        let request = URLRequest(url: URL(string: path)!)
                
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if let unwrappedData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                
                    self.receivedData(data: json as AnyObject)
                    
                } catch {
                    print("Error fetching data")
                }
            } else {
                print("Unable to retrieve data")
            }
        })
        task.resume()
    }
    
    fileprivate func makeHTTPPostRequest(path: String, body: Data) {
        
        var request = URLRequest(url: URL(string: path)!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if error != nil{
                print("Error \(String(describing: error))")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401{
                    print("Refresh token...")
                    return
                } else {
                    print(httpResponse.statusCode)
                    return
                }
            }
        })
        task.resume()
    }
    
    fileprivate func makeHTTPPatchRequest(path: String, body: Data) {
        
        var request = URLRequest(url: URL(string: path)!)
        
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if error != nil{
                print("Error \(String(describing: error))")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401{
                    print("Refresh token...")
                    return
                } else {
                    print(httpResponse.statusCode)
                    return
                }
            }
        })
        task.resume()
    }
    
    fileprivate func makeHTTPDeletetRequest(path: String) {
        
        var request = URLRequest(url: URL(string: path)!)
        
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if error != nil{
                print("Error \(String(describing: error))")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401{
                    print("Refresh token...")
                    return
                } else {
                    print(httpResponse.statusCode)
                    return
                }
            }
        })
        task.resume()
    }
    
    fileprivate func convertToJSON(data: User) -> [String:Any]? {
        if let user = data as? User {
            
            var dict = [String:Any]()
            
            if let firstName = user.firstName { dict["first_name"] = firstName }
            
            if let lastName = user.lastName { dict["last_name"] = lastName }
            
            if let email = user.email { dict["email"] = email }
            
            if let isOverhead = user.isOverhead { dict["is_overhead"] = isOverhead }
            
            if let jobTitle = user.jobTitle { dict["job_title"] = jobTitle }
            
            return dict
        }
        return nil
    }
    
    @objc func receivedData(data: AnyObject?) {
        // implement in subclasses
        
    }
    
    func updateData(id: Int?) {
        
    }
    
    func deletedData(id: Int?) {
        // implement in subclasses
        
    }
    
}
