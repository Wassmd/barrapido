//
//  Constants.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 21/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

struct Constants {
    
    struct urlConstants {
        
        static let BASE_URL = "https://www.barrapido.com/app/"
        static let REGISTER_DEVICE = "register_device.php"
        static let GET_SESSION_KEY = "get_session_key.php"
        static let GET_LOCATION_KEY = "get_location_data.php"
        
        //response time out
        static let TIME_OUT = 30.0
    }
    
    struct JSONResponseKeys {
        
        static let AUTH_KEY = "auth_key"
        static let SESSION_KEY = "session_key"
    }
}
