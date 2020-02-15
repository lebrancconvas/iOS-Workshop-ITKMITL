//
//  ChatViewController.swift
//  Messaging
//
//  Created by Piyatat  Thianboonsong on 13/2/2563 BE.
//  Copyright © 2563 iTiiiM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var channel: String?
    var chatCollection: [QueryDocumentSnapshot] = []
    
    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = channel
        tableView.separatorStyle = .none
        addChatListener()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadAllChats()
    }
    
    func addChatListener() {
        // Add listener to documents to update chat sort by timeStamp
        db.collection("channels").addSnapshotListener { (snapShot, error) in
            if error != nil {
                print(error!)
            } else {
                self.chatCollection = snapShot!.documents
            }
        }
    }
    
    func loadAllChats() {
        
    }
    
    @IBAction func sendButtonDidTapped(_ sender: Any) {
        let message = ["senderName": Auth.auth().currentUser?.displayName, "messageBody": messageTextField.text!]
        db.collection("channels").document(channel ?? "").collection("messages").addDocument(data: message)
    }
}

extension ChatViewController: UITableViewDelegate {
    
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let senderName = chatCollection[indexPath.row].data()["sendername"] as? String
        let messageBody = chatCollection[indexPath.row].data()["messageBody"] as? String
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMessageCell") as! MyMessageCell
        cell.configCell(name: senderName ?? "", message: messageBody ?? "")
        return UITableViewCell()
    }
}
