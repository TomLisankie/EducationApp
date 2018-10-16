//
//  WebContentViewController.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/26/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import UIKit
import WebKit

class WebContentViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView : WKWebView!
    
    var links : [String : String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load a link
        let linkTitles = links?.keys
        let contentURL = URL(string: links?[(linkTitles?.randomElement())!] ?? "title1")
        let urlRequest = URLRequest(url: contentURL!)
        webView.load(urlRequest)
        
    }
    
    @IBAction func yesButtonTapped(){
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            var contentRatings = currentUser!["content_ratings"] as! [String : String]
            var formattedURL = webView.url?.absoluteString as! String
            contentRatings[formattedURL.replacingOccurrences(of: ".", with: "~dot~") ] = "Y"
            currentUser!["content_ratings"] = contentRatings
            print(currentUser!["content_ratings"])
            currentUser?.saveInBackground()
            
            print("User found article helpful")
        } else {
            
            print("No current user")
            
        }
        
    }
    
    @IBAction func noButtonTapped(){
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            var contentRatings = currentUser!["content_ratings"] as! [String : String]
            var formattedURL = webView.url?.absoluteString as! String
            contentRatings[formattedURL.replacingOccurrences(of: ".", with: "~dot~") ] = "N"
            currentUser!["content_ratings"] = contentRatings
            print(currentUser!["content_ratings"])
            currentUser?.saveInBackground()
            
            print("User did not find article helpful")
        } else {
            
            print("No current user")
            
        }
        
    }
    
}
