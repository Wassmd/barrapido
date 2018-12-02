//
//  RegisterDeviceService.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 22/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

protocol RegisterDeviceProtocol: class {
    
    func registerDevice(_ completion: @escaping ((Result<String, ErrorResult>) -> Void))
}

final class RegisterDeviceService {
    
    static let shared = RegisterDeviceService()
    
    /* End point of register device url */
    let registerDeviceUrl = Constants.urlConstants.BASE_URL + Constants.urlConstants.REGISTER_DEVICE
    
    var task: URLSessionTask?
    
    func registerDevice(_ completion: @escaping ((Result<String, ErrorResult>) -> Void)) {
        
        /* cancel registration task if any */
        cancelRegisterDeviceTask()
        
        /* get unique device UDID */
        guard let UDID = getDeviceUDID() else {
            
            print("failed to get device id. Hence registeration failed")
            return
        }
        
        let jsonBody = "{ \"apple_device_id\": \"\(UDID)\" }"
        
        task = NetworkService().requestPostMethodAPI(registerDeviceUrl, jsonBody: jsonBody) { result in
            
            switch result {
                
            case .success(let data):
                
                print(String(data: data, encoding: .utf8) as Any)
                
                JSONParser.parse(data: data, key: Constants.JSONResponseKeys.AUTH_KEY, completion: completion)
                break
                
            case .failure( let error ):
                completion(.failure(error))
                break
            }
        }
    }
    
    func cancelRegisterDeviceTask() {
        
        if let task = task {
            task.cancel()
        }
        
        task = nil
    }
}

