//
//  ViewController.swift
//  dawnhill
//
//  Created by 小刘 on 16/5/30.
//  Copyright © 2016年 小刘. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let stdID = studentIDTextField.text
        let password = passwordTextField.text
        
        
        // Set HTTP request
        let myUrl = NSURL(string: "http://lixueweb.com/app/login.php")
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "studentnum=" + stdID! + "&password=" + password!
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        // Set task
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {data, response, error in
            
            if error != nil {
                // Error occured
                print("error=\(error)")
                return
            }
            
            
            // Create json object
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
            
            
                if let resultValue = json["status"] as? String {
                print("result: \(resultValue)")
                
                    if(resultValue=="OK"){
                    // Login is successfull
                    self.resultLabel.text = "yeah"
                        }
                    }
                } catch {print(error)}
        }
        
        task.resume()
    }

    

}

