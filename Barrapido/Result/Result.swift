//
//  Result.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 21/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

enum Result<T, E:Error> {
    
    case success(T)
    case failure(E)
}
