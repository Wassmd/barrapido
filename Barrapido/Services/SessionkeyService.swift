//
//  SessionkeyService.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 22/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

protocol SessionKeyServiceProtocol: class {
    
    func registerDevice(_ completion: @escaping ((Result<String, ErrorResult>) -> Void))
}

final class SessionKeyService {
    
    static let shared = SessionKeyService()
    
    /* End point of register device url */
    let getSessionUrl = Constants.urlConstants.BASE_URL + Constants.urlConstants.GET_SESSION_KEY
    
    var task: URLSessionTask?
    
    func getSessionkey(auth_key:String, _ completion: @escaping ((Result<String, ErrorResult>) -> Void)) {
        
        /* Cancel the onging task if any */
        cancelGetSessionKeyTask()
        
        let jsonBody = "{ \"auth_key\": \"\(auth_key)\" }"
        
        task = NetworkService().requestPostMethodAPI(getSessionUrl, jsonBody: jsonBody) { result in
            
            switch result {
                
            case .success(let data):
                
                print(String(data: data, encoding: .utf8) as Any)
                
                JSONParser.parse(data: data, key: Constants.JSONResponseKeys.SESSION_KEY, completion: completion)
                
                break
                
            case .failure( let error ):
                completion(.failure(error))
                break
                
            }
        }
    }
    
    func cancelGetSessionKeyTask() {
        
        if let task = task {
            task.cancel()
        }
        
        task = nil
    }
}
