//
//  Util.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 22/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation
import UIKit

func getDeviceUDID() -> String? {
    
    return UIDevice.current.identifierForVendor?.uuidString

}

func parseQRCode(urlString:String) -> String? {
    
    var dict = [String:String]()
    let components = URLComponents(url: URL(string: urlString)!, resolvingAgainstBaseURL: false)!
    if let queryItems = components.queryItems {
        for item in queryItems {
            dict[item.name] = item.value!
        }
    }
    print(dict)
    
    return dict["q"]
}












