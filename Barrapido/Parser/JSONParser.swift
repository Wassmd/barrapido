//
//  JSONParser.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 22/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

protocol Parceable {
    
    static func parseObject(dict:[String:AnyObject]) -> Result<Self,ErrorResult>
}
final class JSONParser {
    
    static func parse(data:Data, key:String, completion:(Result<String,ErrorResult>) -> Void) {
        
        do {
            
            if let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] {
                
                if let value = dict[key] as? String {
                    
                    completion(.success(value))
                    
                }else {
                    
                    completion(.failure(.parser("Key not found while parsing")))
                }
            }
            
        }catch {
            
            completion(.failure(.parser("Error while parsing json data")))
        }
       
    }
    
    static func parse<T:Codable>(data:Data, completion:(Result<T,ErrorResult>) -> Void) {
        
        do {
            
           
            let model = try JSONDecoder().decode(T.self, from: data)
            
            print(model)
            
            completion(.success(model))
            
        }catch {
            
            completion(.failure(.parser("Error while parsing json data location data")))
        }
        
    }
    
}
