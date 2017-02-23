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
    var entrantHolder: EntrantType! // Implicitly unwrapped because it will always have a value.
    var newPass: Pass!
    
    @IBOutlet weak var generatePass: UIButton!
    
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
        sender.showsTouchWhenHighlighted = true
        switch sender {
        case guestButton:
            showButtons(button: guestButton)
            changeColor(sender: sender)
            normalColor(sender: sender)
        case employeeButton:
            showButtons(button: employeeButton)
            changeColor(sender: sender)
            normalColor(sender: sender)
        case managerButton:
            showButtons(button: managerButton)
            entrantHolder = Employee.manager
            changeColor(sender: sender)
            checkEntrant()
        case vendorButton:
            showButtons(button: vendorButton)
            entrantHolder = Other.vendor
            changeColor(sender: sender)
            checkEntrant()
        default:
            break
        }
    }

    @IBAction func detailedEntrantSelection(_ sender: UIButton) {
        sender.showsTouchWhenHighlighted = true
        switch sender {
        case typeOneButton:
            //sender.showsTouchWhenHighlighted = true
            if typeOneButton.title(for: .normal) == "Child"{
                changeColor(sender: sender)
                activateTextField(typeName: "Child")
                entrantHolder = Guest.freechild
                checkEntrant()
            } else {
                changeColor(sender: sender)
                activateTextField(typeName: "Food Service")
                entrantHolder = Employee.foodeService
                checkEntrant()
            }
        case typeTwoButton:
            if typeTwoButton.title(for: .normal) == "Classic" {
                changeColor(sender: sender)
                activateTextField(typeName: "Classic")
                entrantHolder = Guest.classic
                checkEntrant()
            } else {
                changeColor(sender: sender)
                activateTextField(typeName: "Ride Service")
                entrantHolder = Employee.rideService
                checkEntrant()
            }
        case typeThreeButton:
            if typeThreeButton.title(for: .normal) == "VIP" {
                changeColor(sender: sender)
                activateTextField(typeName: "VIP")
                entrantHolder = Guest.vip
                checkEntrant()
            } else {
                changeColor(sender: sender)
                activateTextField(typeName: "Maintenance")
                entrantHolder = Employee.manager
                checkEntrant()
            }
        case typeFourButton:
            if typeFourButton.title(for: .normal) == "Season" {
                changeColor(sender: sender)
                activateTextField(typeName: "Season")
                entrantHolder = Guest.season
               checkEntrant()
            } else {
                changeColor(sender: sender)
                activateTextField(typeName: "Contract")
                entrantHolder = Employee.contract
                checkEntrant()
            }
        case typeFiveButton:
            if typeFiveButton.title(for: .normal) == "Senior" {
                changeColor(sender: sender)
                activateTextField(typeName: "Senior")
                entrantHolder = Guest.senior
                checkEntrant()
            }
        default: break
        }
    }
    
    @IBAction func generatePass(_ sender: UIButton) {
        do {
             newPass = try Pass(firstName: firstName.text, lastName: lastName.text, streetAddress: streetAddress.text, city: city.text, state: state.text, zipCode: zipCode.text, dateOfBirth: dateOfBirth.text, vendorCompany: company.text, entrant: entrantHolder!)
            
        } catch creationError.firstName {
            showAlert(title: "Missing Information", message: creationError.firstName.rawValue)
        } catch creationError.lastName {
            showAlert(title: "Missing Information", message: creationError.lastName.rawValue)
        } catch  creationError.streetAddress {
            showAlert(title: "Missing Information", message: creationError.streetAddress.rawValue)
        } catch creationError.city {
            showAlert(title: "Missing Information", message: creationError.city.rawValue)
        } catch creationError.state {
            showAlert(title: "Missing Information", message: creationError.state.rawValue)
        } catch creationError.zipCode {
            showAlert(title: "Missing Information", message: creationError.zipCode.rawValue)
        } catch creationError.dateOfBirth {
            showAlert(title: "Missing Information", message: creationError.dateOfBirth.rawValue)
        } catch creationError.vendor {
            showAlert(title: "Missing Information", message: creationError.vendor.rawValue)
        } catch {
            
        }
    }
    
    /* The populate data button automatically inputs data to create a pass for a classic entrant to test the pass generator */
    @IBAction func populateData(_ sender: UIButton) {
        entrantHolder = Guest.classic
        dateOfBirth.text = "01/01/1901"
        firstName.text = "Jane"
        lastName.text = "Doe"
        streetAddress.text = "1000 Pleasant Lane"
        city.text = "Happy"
        state.text = "CA"
        zipCode.text = "55555"
        generatePass.isEnabled = true
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPass" {
            let destinationVC = segue.destination as! PassViewController
            destinationVC.entrantPass = newPass
            entrantHolder = nil
            checkEntrant()
            deleteText()
        }
    }
    
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)

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
    
    func checkEntrant() {
        if entrantHolder == nil {
            generatePass.isEnabled = false
        } else {
            generatePass.isEnabled = true
        }
    }
    
    func deleteText() {
        dateOfBirth.text = ""
        ssn.text = ""
        projectNumber.text = ""
        firstName.text = ""
        lastName.text = ""
        company.text = ""
        streetAddress.text = ""
        city.text = ""
        state.text = ""
        zipCode.text = ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generatePass.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeColor(sender: UIButton) {
        switch sender {
        case guestButton:
          guestButton.setTitleColor(UIColor.lightGray, for: .normal)
            employeeButton.setTitleColor(UIColor.white, for: .normal)
            managerButton.setTitleColor(UIColor.white, for: .normal)
            vendorButton.setTitleColor(UIColor.white, for: .normal)
        case employeeButton:
            employeeButton.setTitleColor(UIColor.lightGray, for: .normal)
            guestButton.setTitleColor(UIColor.white, for: .normal)
            managerButton.setTitleColor(UIColor.white, for: .normal)
            vendorButton.setTitleColor(UIColor.white, for: .normal)
        case managerButton:
            managerButton.setTitleColor(UIColor.lightGray, for: .normal)
            guestButton.setTitleColor(UIColor.white, for: .normal)
            employeeButton.setTitleColor(UIColor.white, for: .normal)
            vendorButton.setTitleColor(UIColor.white, for: .normal)
        case vendorButton:
            vendorButton.setTitleColor(UIColor.lightGray, for: .normal)
            guestButton.setTitleColor(UIColor.white, for: .normal)
            employeeButton.setTitleColor(UIColor.white, for: .normal)
            managerButton.setTitleColor(UIColor.white, for: .normal)
        case typeOneButton:
            typeOneButton.setTitleColor(UIColor.lightGray, for: .normal)
            typeTwoButton.setTitleColor(UIColor.white, for: .normal)
            typeThreeButton.setTitleColor(UIColor.white, for: .normal)
            typeFourButton.setTitleColor(UIColor.white, for: .normal)
            typeFiveButton.setTitleColor(UIColor.white, for: .normal)
        case typeTwoButton:
            typeOneButton.setTitleColor(UIColor.white, for: .normal)
            typeTwoButton.setTitleColor(UIColor.lightGray, for: .normal)
            typeThreeButton.setTitleColor(UIColor.white, for: .normal)
            typeFourButton.setTitleColor(UIColor.white, for: .normal)
            typeFiveButton.setTitleColor(UIColor.white, for: .normal)
        case typeThreeButton:
            typeOneButton.setTitleColor(UIColor.white, for: .normal)
            typeTwoButton.setTitleColor(UIColor.white, for: .normal)
            typeThreeButton.setTitleColor(UIColor.lightGray, for: .normal)
            typeFourButton.setTitleColor(UIColor.white, for: .normal)
            typeFiveButton.setTitleColor(UIColor.white, for: .normal)
        case typeFourButton:
            typeOneButton.setTitleColor(UIColor.white, for: .normal)
            typeTwoButton.setTitleColor(UIColor.white, for: .normal)
            typeThreeButton.setTitleColor(UIColor.white, for: .normal)
            typeFourButton.setTitleColor(UIColor.lightGray, for: .normal)
            typeFiveButton.setTitleColor(UIColor.white, for: .normal)
        case typeFiveButton:
            typeOneButton.setTitleColor(UIColor.white, for: .normal)
            typeTwoButton.setTitleColor(UIColor.white, for: .normal)
            typeThreeButton.setTitleColor(UIColor.white, for: .normal)
            typeFourButton.setTitleColor(UIColor.white, for: .normal)
            typeFiveButton.setTitleColor(UIColor.lightGray, for: .normal)
        default:
            break
        }
    }
    
    func normalColor(sender: UIButton) {
        switch sender {
        case guestButton:
            typeOneButton.setTitleColor(UIColor.white, for: .normal)
            typeTwoButton.setTitleColor(UIColor.white, for: .normal)
            typeThreeButton.setTitleColor(UIColor.white, for: .normal)
            typeFourButton.setTitleColor(UIColor.white, for: .normal)
            typeFiveButton.setTitleColor(UIColor.white, for: .normal)
        case employeeButton:
            typeOneButton.setTitleColor(UIColor.white, for: .normal)
            typeTwoButton.setTitleColor(UIColor.white, for: .normal)
            typeThreeButton.setTitleColor(UIColor.white, for: .normal)
            typeFourButton.setTitleColor(UIColor.white, for: .normal)
            typeFiveButton.setTitleColor(UIColor.white, for: .normal)
        default:
            break
        }
    }
    
}

