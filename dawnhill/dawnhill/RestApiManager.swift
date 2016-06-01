//
//  RestApiManager.swift
//  dawnhill
//
//  Created by 小刘 on 16/5/30.
//  Copyright © 2016年 小刘. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://lixueweb.com/app/login.php"
    
    func getRandomUser(onCompletion: (JSON) -> Void) {
        makeHTTPGetRequest(baseURL, onCompletion: { json, err -> Void in
            onCompletion(json)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error in
            let json: JSON = JSON(data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}