//
//  Access.swift
//  NewAmusementPark
//
//  Created by Cori Mims on 2/12/17.
//  Copyright © 2017 Cori Mims. All rights reserved.
//

import Foundation

import UIKit

protocol Accessible {
    static var discountAmount: [String : [Float]] { get }
    static func areaSwipe(pass: Pass) -> String
    static func rideSwipe(pass: Pass) -> String
    static func discountSwipe(pass: Pass) -> String
}

// Created static methods in Access class to be able to call them directly.

class Access: Accessible {
    static let discountAmount: [String: [Float]] = ["employee": [15, 20], "manager": [25, 25], "vip": [10, 20]]
    
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
    
    // Dictionary values are force unwrapped because because they will always have a value
    
    static func discountSwipe(pass: Pass) -> String {
        switch pass.entrant {
        case Employee.foodeService, Employee.contract, Employee.maintenance, Employee.rideService:
            return "Entrant is entitled to a \(discountAmount["employee"]![0])% discount on food and a \(discountAmount["employee"]![1])% discount on merchandise"
        case Employee.manager:
            return "Entrant is entitled to a \(discountAmount["manager"]![0])% discount on food and a \(discountAmount["manager"]![1])% discount on merchandise"
        case Guest.vip:
            return "Entrant is entitled to a \(discountAmount["vip"]![0])% discount on food and a \(discountAmount["vip"]![1])% discount on merchandise"
        default:
            return "No Discounts Available"
        }
    }
    
    static func labelChange(pass: Pass, labelOne: UILabel, labelTwo: UILabel) {
        switch pass.entrant {
        case Employee.foodeService, Employee.maintenance, Employee.rideService:
            labelOne.text = "\(discountAmount["employee"]![1])% discount on merchandise"
            labelTwo.text = "\(discountAmount["employee"]![0])% discount on food"
        case Employee.manager:
            labelOne.text = "\(discountAmount["manager"]![1])% discount on merchandise"
            labelTwo.text = "\(discountAmount["manager"]![0])% discount on food"
        case Guest.vip:
            labelOne.text = "\(discountAmount["vip"]![1])% discount on merchandise"
            labelTwo.text = "\(discountAmount["vip"]![0])% discount on food"
        default:
            labelOne.text = "No Discount Available"
            labelTwo.text = "No Discount Available"

        }
    }
}

