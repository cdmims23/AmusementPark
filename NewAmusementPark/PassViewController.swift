//
//  PassViewController.swift
//  NewAmusementPark
//
//  Created by Cori Mims on 2/15/17.
//  Copyright © 2017 Cori Mims. All rights reserved.
//

import UIKit

class PassViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var testResults: UILabel!
    @IBOutlet weak var entrantTypeLabel: UILabel!
    @IBOutlet weak var merchandiseDiscount: UILabel!
    @IBOutlet weak var areaAccess: UIButton!
    @IBOutlet weak var rideAccess: UIButton!
    @IBOutlet weak var discountAccess: UIButton!
    
    
    
    var entrantPass: Pass!
    
    @IBAction func accessFunction(_ sender: UIButton) {
        var accessResult: String
        
        switch sender {
        case discountAccess:
            accessResult = Access.discountSwipe(pass: entrantPass)
            testResults.text = accessResult
        case rideAccess:
            accessResult = Access.rideSwipe(pass: entrantPass)
            testResults.text = accessResult
        case areaAccess:
            accessResult = Access.areaSwipe(pass: entrantPass)
            testResults.text = accessResult
        default:
            break
        }
    }

    // Picker for camera.
    let picker = UIImagePickerController()
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    @IBAction func createNewPass(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         picker.delegate = self
         nameLabel.text = "\(entrantPass.firstName!) \(entrantPass.lastName!)"
        entrantTypeLabel.text = entrantPass.entrant.newValue
        //merchandiseDiscount.text = Access.discountAmount[""]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func noCamera() {
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
   
}
