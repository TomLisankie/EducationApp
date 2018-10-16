//
//  LogInViewController.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/26/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var logInError : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logInPressed() {
        
        PFUser.logInWithUsername(inBackground: email.text!, password: password.text!, block: {
            (user, error) in
            userExists: if user != nil{
                
                self.performSegue(withIdentifier: "toTopicsFromLogIn", sender: self)
                
            }else {
                
                self.logInError.isHidden = false
                
            }
            
            
        })
        
    }
    
}
