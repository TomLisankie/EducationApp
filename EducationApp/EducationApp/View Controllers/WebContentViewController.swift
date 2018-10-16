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
    
}
