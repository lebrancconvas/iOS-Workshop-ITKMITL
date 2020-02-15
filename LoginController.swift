//
//  ViewController.swift
//  Messaging
//
//  Created by Piyatat  Thianboonsong on 13/2/2563 BE.
//  Copyright © 2563 iTiiiM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PopupDialog

class ViewController: UIViewController {
    
    var db: Firestore?
  
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var displayNameStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displaynameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            displayNameStackView.isHidden = false
        default:
            displayNameStackView.isHidden = true
        }
    }
    
    @IBAction func submitButtonDidTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // Register Submit Button Did Tapped
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (result, error) in
                if error != nil {
                    self.showAlert(title: "ERROR", message: "Invalid E-Mail \n Password must be longer than 6 characters.")
                } else {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "Poomkun"
                    changeRequest?.commitChanges(completion: { (error) in
                        if error != nil {
                            print(error!)
                        } else {
                            self.showAlert(title: "Success", message: "ยินดีด้วยคุณล็อกอินสำเร็จแล้ว")
                        }
                    })
                }
            }
            break
        default:
            // Login Submit Button Did Tapped
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (result, error) in
                if error != nil {
                    self.showAlert(title: "Login ERROR", message: "")
                } else {
                    self.performSegue(withIdentifier: "toAllRooms", sender: nil)
                }
            }
//            showAlert(title: "You just tapped on login", message: "")
            break
        }
    }
}

