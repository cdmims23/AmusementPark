//
//  Access.swift
//  NewAmusementPark
//
//  Created by Cori Mims on 2/12/17.
//  Copyright © 2017 Cori Mims. All rights reserved.
//

import Foundation

import Foundation

protocol Accessable {
    
    static func areaSwipe(pass: Pass) -> String
    static func rideSwipe(pass: Pass) -> String
    static func discountSwipe(pass: Pass) -> String
}

// Created static methods in Access class to be able to call the directly.

class Access: Accessable {
    
    init() {
        
    }
    
    static func areaSwipe(pass: Pass) -> String {
        switch pass.entrant {
        case Guest.classic :
            return "Amusement Areas"
        case Guest.freechild:
            return "Amusement Areas"
        case Guest.vip:
            return "Amusment Areas"
        case Employee.foodeService:
            return ".Amusement Areas, Kitchen Areas"
        case Employee.rideService:
            return "Amusement Areas, Ride Control Areas"
        case Employee.maintenance:
            return "Amusement Areas, Kitchen Areas, Ride Control Areas, Maintenance Areas"
        case Employee.manager:
            return "Amusement Areas, Kitchen Areas, Ride Control Areas, Maintenance Areas, Office Areas"
        default:
            return "None"
        }
    }
    
    static func rideSwipe(pass: Pass) -> String {
        switch pass.entrant{
        case Guest.vip:
            return "Access All Rides & Skip All Ride Lines"
        default:
            return "Access All Rides"
        }
    }
    
    static func discountSwipe(pass: Pass) -> String {
        switch pass.entrant {
        case Employee.foodeService, Employee.maintenance, Employee.rideService:
            return "Entrant is entitled to a 15% discount on food and a 20% discount on merchandise"
        case Employee.manager:
            return "Entrant is entitled to a 25% discount on food and a 25% discount on merchandise"
        case Guest.vip:
            return "Entrant is entitled to a 10% discount on food and a 20% discount on merchandise"
        default:
            return "None"
            
        }
    }
}

