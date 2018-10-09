//
//  UIViewControllerExtension.swift
//  EducationApp
//
//  Created by Thomas Lisankie on 10/8/18.
//  Copyright © 2018 Thomas Lisankie. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorView(_ error: Error?) {
        guard let error = error as? NSError, let errorMessage = error.userInfo["error"] as? String else {
            return
        }
        
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""),
                                                message: errorMessage,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""),
                                                style: .default))
        
        present(alertController, animated: true)
    }
}
