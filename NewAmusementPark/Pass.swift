//
//  Pass.swift
//  NewAmusementPark
//
//  Created by Cori Mims on 2/12/17.
//  Copyright © 2017 Cori Mims. All rights reserved.
//

import Foundation

protocol EntrantType {
    var newValue: String { get }
}

extension EntrantType {
    var newValue: String {
        return self.newValue
    }
}

enum Employee: String, EntrantType {
    case foodeService = "Food Service"
    case rideService = "Ride Service"
    case maintenance = "Maintenance"
    case manager = "Manager"
    case contract = "Contract"
    
    var newValue: String {
        return self.rawValue
    }
}

enum Guest: String, EntrantType {
    case classic = "Classic Guest"
    case vip = "VIP Guest"
    case freechild = "Child Guest"
    case season = "Seasonal Guest"
    case senior = "Senior Guest"
    
    var newValue: String {
        return self.rawValue
    }
}

enum Other: String, EntrantType {
    case vendor = "Vendor"
    
    var newValue: String {
        return self.rawValue
    }
}

enum creationError: String, Error{
    case dateOfBirth = "Please enter a birthdate"
    case firstName = "Please enter the first name"
    case lastName = "Please enter the last name"
    case streetAddress = "Please enter an address"
    case city = "Please enter a city"
    case state = "Please enter a state"
    case zipCode = "Please enter a zip code"
    case vendor = "Please enter the Vendor Company"
}

class Pass: EntrantType {
    let firstName: String?
    let lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
    let dateOfBirth: String?
    var vendorCompany: String?
    let entrant: EntrantType
    
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: String?, dateOfBirth: String?, vendorCompany: String?, entrant: EntrantType) throws {
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dateOfBirth = dateOfBirth
        self.vendorCompany = vendorCompany
        self.entrant = entrant
        
        switch entrant {
        case Employee.foodeService, Employee.maintenance, Employee.manager, Employee.rideService, Guest.season, Employee.contract:
            if self.firstName == "" {
                throw creationError.firstName
            } else if self.lastName == "" {
                throw creationError.lastName
            } else if self.streetAddress == "" {
                throw creationError.streetAddress
            } else if self.city == "" {
                throw creationError.city
            } else if self.state == "" {
                throw creationError.state
            } else if self.zipCode == "" {
                throw creationError.zipCode
            }
        case Guest.freechild:
            if self.dateOfBirth == "" {
                throw creationError.dateOfBirth
            }
            
        case Guest.senior:
            if self.firstName == "" {
                throw creationError.firstName
            } else if self.lastName == "" {
                throw creationError.lastName
            } else if self.dateOfBirth == "" {
                throw creationError.dateOfBirth
            }
            
        case Other.vendor:
            if self.firstName == "" {
                throw creationError.firstName
            } else if self.lastName == "" {
                throw creationError.lastName
            } else if self.dateOfBirth == "" {
                throw creationError.dateOfBirth
            } else if self.vendorCompany == "" {
                throw creationError.vendor
            }
        default:
            break
        }
    }
}

