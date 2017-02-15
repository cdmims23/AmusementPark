//
//  Pass.swift
//  NewAmusementPark
//
//  Created by Cori Mims on 2/12/17.
//  Copyright © 2017 Cori Mims. All rights reserved.
//

import Foundation

protocol EntrantType {
    
}

enum Employee: EntrantType {
    case foodeService
    case rideService
    case maintenance
    case manager
    case contract
}

enum Guest: EntrantType {
    case classic
    case vip
    case freechild
    case season
    case senior
}

enum Other: EntrantType {
    case vendor
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
            if self.firstName == nil {
                throw creationError.firstName
            } else if self.lastName == nil {
                throw creationError.lastName
            } else if self.streetAddress == nil {
                throw creationError.streetAddress
            } else if self.city == nil {
                throw creationError.city
            } else if self.state == nil {
                throw creationError.state
            } else if self.zipCode == nil {
                throw creationError.zipCode
            }
        case Guest.freechild:
            if self.dateOfBirth == nil {
                throw creationError.dateOfBirth
            }
            
        case Guest.senior:
            if self.firstName == nil {
                throw creationError.firstName
            } else if self.lastName == nil {
                throw creationError.lastName
            } else if self.dateOfBirth == nil {
                throw creationError.dateOfBirth
            }
            
        case Other.vendor:
            if self.firstName == nil {
                throw creationError.firstName
            } else if self.lastName == nil {
                throw creationError.lastName
            } else if self.dateOfBirth == nil {
                throw creationError.dateOfBirth
            } else if self.vendorCompany == nil {
                throw creationError.vendor
            }
        default:
            break
        }
    }
}

