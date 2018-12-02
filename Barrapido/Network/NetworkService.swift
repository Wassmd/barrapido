//
//  NetworkService.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 21/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private var session = URLSession.shared
    
    func requestPostMethodAPI(_ urlString: String, jsonBody: String, completionHandler: @escaping (Result<Data,ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            
            completionHandler(.failure(.network("Wrong url format")))
            return nil
        }
        
       let request =  NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringCacheData
            , timeoutInterval:Constants.urlConstants.TIME_OUT )
        
        request.httpMethod = "POST"
        request.httpBody = jsonBody.data(using: .utf8)
        
        //to debug the url
        print(request.description)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                
                completionHandler(.failure(.network("An error occured during request:" + error.localizedDescription)))
                
                return
            }
            
            if let data = data {
                
                completionHandler(.success(data))
            }
        }
        
        task.resume()
        return task
    }
}
