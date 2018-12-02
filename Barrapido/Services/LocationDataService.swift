//
//  LocationDataService.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 25/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

protocol LocationDataServiceProtocol: class {
    
     func getLocationData(session_key:String,qrCode:String,islocation:Int,lat:Float,lon:Float, _ completion: @escaping ((Result<LocationData, ErrorResult>) -> Void))
}

final class LocationDataService:LocationDataServiceProtocol {
    
    static let shared = LocationDataService()
    
    /* End point of register device url */
    let getLocationDataURL = Constants.urlConstants.BASE_URL + Constants.urlConstants.GET_LOCATION_KEY
    
    var task: URLSessionTask?
    
    func getLocationData(session_key:String,qrCode:String,islocation:Int,lat:Float,lon:Float, _ completion: @escaping ((Result<LocationData, ErrorResult>) -> Void)) {
        
        /* Cancel the onging task if any */
        cancelGetLocationDataTask()
        
        let jsonBody = "{ \"session_key\":\"\(session_key)\",\"scanned_code\":\"\(qrCode)\",\"location\":\(islocation),\"lat\":\(lat),\"lon\":\(lon) }"
        
        task = NetworkService().requestPostMethodAPI(getLocationDataURL, jsonBody: jsonBody) { result in
            
            switch result {
                
            case .success(let data):
                
              //  print(String(data: data, encoding: .utf8) as Any)
                
                JSONParser.parse(data: data, completion: completion)
                
                break
                
            case .failure( let error ):
                print(error)
                completion(.failure(error))
                break
                
            }
        }
    }
    
    func cancelGetLocationDataTask() {
        
        if let task = task {
            task.cancel()
        }
        
        task = nil
    }
}
