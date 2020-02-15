//
//  AddRoomViewController.swift
//  Messaging
//
//  Created by Piyatat  Thianboonsong on 13/2/2563 BE.
//  Copyright © 2563 iTiiiM. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AddRoomViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var channelnameTextField: UITextField!
    @IBOutlet weak var channeldescriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addRoomButtonDidTapped(_ sender: Any) {
        db.collection("channels").document(channelnameTextField.text!).setData(["name": channelnameTextField.text!, "description": channeldescriptionTextField.text!])
        self.navigationController?.popViewController(animated: true)
    }
}
