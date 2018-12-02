//
//  AppDelegate+Extension.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 23/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation
import UIKit
/**
 It shows Alert to a give view Controller
 - Parameter vc: viewcontroll who will present
 - Parameter title: String
 - Paramter message: message to display
 */
func showAlertMessage(_ vc:UIViewController,title:String = "Barrapido" , _ message:String) {
    
    // create the alert
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
    // show the alert
    vc.present(alert, animated: true, completion: nil)
}
