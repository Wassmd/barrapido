//
//  Error.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 21/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

enum ErrorResult:Error {
    
    case network(String)
    case parser(String)
    case custom(String)
}
