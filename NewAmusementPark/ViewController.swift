//
//  ViewController.swift
//  NewAmusementPark
//
//  Created by Cori Mims on 2/12/17.
//  Copyright © 2017 Cori Mims. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
  
    // Hold Entrant.
    var entrantHolder: EntrantType
    
    // Entrant Buttons.
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var employeeButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    @IBOutlet weak var vendorButton: UIButton!
    
    // Detailed Entrant Buttons.
    @IBOutlet weak var typeOneButton: UIButton!
    @IBOutlet weak var typeTwoButton: UIButton!
    @IBOutlet weak var typeThreeButton: UIButton!
    @IBOutlet weak var typeFourButton: UIButton!
    @IBOutlet weak var typeFiveButton: UIButton!

    
    // Input Outlets.
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var ssn: UITextField!
    @IBOutlet weak var projectNumber: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    // Button Functions.
    
    @IBAction func entrantSelection(_ sender: UIButton) {
        switch sender {
        case guestButton:
            showButtons(button: guestButton)
        case employeeButton:
            showButtons(button: employeeButton)
        case managerButton:
            showButtons(button: managerButton)
            entrantHolder = Employee.manager
        case vendorButton:
            showButtons(button: vendorButton)
            entrantHolder = Other.vendor
        default:
            break
        }
    }

    @IBAction func detailedEntrantSelection(_ sender: UIButton) {
        switch sender {
        case typeOneButton:
            if typeOneButton.title(for: .normal) == "Child"{
                activateTextField(typeName: "Child")
                entrantHolder = Guest.freechild
            } else {
                activateTextField(typeName: "Food Service")
                entrantHolder = Employee.foodeService
            }
        case typeTwoButton:
            if typeTwoButton.title(for: .normal) == "Classic" {
                activateTextField(typeName: "Classic")
                entrantHolder = Guest.classic
            } else {
                activateTextField(typeName: "Ride Service")
                entrantHolder = Employee.rideService
            }
        case typeThreeButton:
            if typeThreeButton.title(for: .normal) == "VIP" {
                activateTextField(typeName: "VIP")
                entrantHolder = Guest.vip
            } else {
                activateTextField(typeName: "Maintenance")
                entrantHolder = Employee.manager
            }
        case typeFourButton:
            if typeFourButton.title(for: .normal) == "Season" {
                activateTextField(typeName: "Season")
                entrantHolder = Guest.season
            } else {
                activateTextField(typeName: "Contract")
                entrantHolder = Employee.contract
            }
        case typeFiveButton:
            if typeFiveButton.title(for: .normal) == "Senior" {
                activateTextField(typeName: "Senior")
                entrantHolder = Guest.senior
            }
        default: break
        }
    }
    
    @IBAction func generatePass(_ sender: UIButton) {
        
        
    }
    
    
    func activateTextField(typeName: String) {
        switch typeName {
        case "Child":
            dateOfBirth.isEnabled = true
            ssn.isEnabled = false
            projectNumber.isEnabled = false
            firstName.isEnabled = false
            lastName.isEnabled = false
            company.isEnabled = false
            streetAddress.isEnabled = false
            city.isEnabled = false
            state.isEnabled = false
            zipCode.isEnabled = false
        case "Food Service", "Ride Service", "Maintenance", "Season", "Contract", "Vendor", "Manager":
            dateOfBirth.isEnabled = false
            ssn.isEnabled = false
            projectNumber.isEnabled = false
            firstName.isEnabled = true
            lastName.isEnabled = true
            company.isEnabled = false
            streetAddress.isEnabled = true
            city.isEnabled = true
            state.isEnabled = true
            zipCode.isEnabled = true
        case "Senior":
            dateOfBirth.isEnabled = true
            ssn.isEnabled = false
            projectNumber.isEnabled = false
            firstName.isEnabled = true
            lastName.isEnabled = true
            company.isEnabled = false
            streetAddress.isEnabled = false
            city.isEnabled = false
            state.isEnabled = false
            zipCode.isEnabled = false
        default:
            dateOfBirth.isEnabled = false
            ssn.isEnabled = false
            firstName.isEnabled = true
            lastName.isEnabled = true
            company.isEnabled = false
            streetAddress.isEnabled = true
            city.isEnabled = true
            state.isEnabled = true
            zipCode.isEnabled = true
        }
    }

    func showButtons(button: UIButton) {
        switch button {
        case guestButton:
            typeOneButton.setTitle("Child", for: .normal)
            typeOneButton.isHidden = false
            typeTwoButton.setTitle("Classic", for: .normal)
            typeTwoButton.isHidden = false
            typeThreeButton.setTitle("VIP", for: .normal)
            typeThreeButton.isHidden = false
            typeFourButton.setTitle("Season", for: .normal)
            typeFourButton.isHidden = false
            typeFiveButton.setTitle("Senior", for: .normal)
            typeFiveButton.isHidden = false
            
        case employeeButton:
            typeOneButton.setTitle("Food", for: .normal)
            typeOneButton.isHidden = false
            typeTwoButton.setTitle("Ride", for: .normal)
            typeTwoButton.isHidden = false
            typeThreeButton.setTitle("Maintenance", for: .normal)
            typeThreeButton.isHidden = false
            typeFourButton.setTitle("Contract", for: .normal)
            typeFourButton.isHidden = false
            typeFiveButton.isHidden = true
            
        case managerButton:
            typeOneButton.isHidden = true
            typeTwoButton.isHidden = true
            typeThreeButton.isHidden = true
            typeFourButton.isHidden = true
            typeFiveButton.isHidden = true
            
        case vendorButton:
            typeOneButton.isHidden = true
            typeTwoButton.isHidden = true
            typeThreeButton.isHidden = true
            typeFourButton.isHidden = true
            typeFiveButton.isHidden = true
            
        default: break
            
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

