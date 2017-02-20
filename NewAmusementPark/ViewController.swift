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
        switch sender {
        case guestButton:
            guestButton.showsTouchWhenHighlighted = true
            showButtons(button: guestButton)
        case employeeButton:
            employeeButton.showsTouchWhenHighlighted = true
            showButtons(button: employeeButton)
        case managerButton:
            managerButton.showsTouchWhenHighlighted = true
            showButtons(button: managerButton)
            entrantHolder = Employee.manager
            checkEntrant()
        case vendorButton:
            vendorButton.showsTouchWhenHighlighted = true
            showButtons(button: vendorButton)
            entrantHolder = Other.vendor
            checkEntrant()
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
                checkEntrant()
            } else {
                activateTextField(typeName: "Food Service")
                entrantHolder = Employee.foodeService
                checkEntrant()
            }
        case typeTwoButton:
            if typeTwoButton.title(for: .normal) == "Classic" {
                activateTextField(typeName: "Classic")
                entrantHolder = Guest.classic
                checkEntrant()
            } else {
                activateTextField(typeName: "Ride Service")
                entrantHolder = Employee.rideService
                checkEntrant()
            }
        case typeThreeButton:
            if typeThreeButton.title(for: .normal) == "VIP" {
                activateTextField(typeName: "VIP")
                entrantHolder = Guest.vip
                checkEntrant()
            } else {
                activateTextField(typeName: "Maintenance")
                entrantHolder = Employee.manager
                checkEntrant()
            }
        case typeFourButton:
            if typeFourButton.title(for: .normal) == "Season" {
                activateTextField(typeName: "Season")
                entrantHolder = Guest.season
               checkEntrant()
            } else {
                activateTextField(typeName: "Contract")
                entrantHolder = Employee.contract
                checkEntrant()
            }
        case typeFiveButton:
            if typeFiveButton.title(for: .normal) == "Senior" {
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
    
    func changeColor(sender: UIButton) {
        sender.setTitleColor(UIColor.lightGray, for: .selected)
        //Edit details later.
        
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


}

