//
//  RegisterViewController.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 9/26/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var emailConfirm : UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var passwordConfirm : UITextField!
    
    @IBOutlet weak var signupError : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signupPressed() {
        
        // Check that emails and passwords match before proceeding to sign-up
        // TODO: Add rules to make sure input is valid.
        if (email.text != emailConfirm.text) || (password.text != passwordConfirm.text) {
            
            signupError.isHidden = false
            return
            
        } else {
            
            var newUser = PFUser()
            newUser.username = email.text
            newUser.password = password.text
            newUser.email = email.text
            newUser["content_ratings"] = [String : String]()
            var contentRatings = newUser["content_ratings"] as! [String : String]
            contentRatings["example link"] = "example score"
            
            newUser.signUpInBackground()
            
            self.performSegue(withIdentifier: "toTopicsFromRegistration", sender: self)
            
        }
        
    }
    
}

