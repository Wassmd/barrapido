//
//  LocationData.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 26/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation

struct LocationData: Codable {
    
    let result: String
    let provider: Provider
    let servicePoint: ServicePoint
    let DeliveryPoint: DeliveryPoint
    
//    let provider: [String: Provider]
//    let servicePoint: [String: ServicePoint]
//    let DeliveryPoint: [String: DeliveryPoint]
    
    enum CodingKeys: String, CodingKey {
        case result
        case provider
        case servicePoint = "service_point"
        case DeliveryPoint = "delivery_point"
    }
}

struct Provider: Codable {
    
    let name: String
    let status: String
    let id: String
}

struct ServicePoint: Codable {
    
    let name: String
    let status: String
    let takingOrders: String
    let id: String
    let welcomeImageURL: String
    let imgWelcome: String
    let imgLogo: String
    let currencyCode: String
    
    private enum CodingKeys: String, CodingKey {
        
        case name
        case status
        case takingOrders = "taking_orders"
        case id
        case welcomeImageURL = "welcome_image"
        case imgWelcome = "img_welcome"
        case imgLogo = "img_logo"
        case currencyCode = "currency_code"
        
    }
}

struct DeliveryPoint: Codable {
    
    let name: String
    let description: String
    let status: String
    let id: String
}
