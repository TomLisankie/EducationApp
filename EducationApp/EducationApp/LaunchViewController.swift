//
//  LaunchViewController.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/26/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logInChoice(_ sender:UIButton){
        
        sender.setTitle("Hello", for: .normal)
        
    }
    
}
