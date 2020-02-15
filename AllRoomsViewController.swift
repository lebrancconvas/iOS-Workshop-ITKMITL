//
//  AllRoomsViewController.swift
//  Messaging
//
//  Created by Piyatat  Thianboonsong on 13/2/2563 BE.
//  Copyright © 2563 iTiiiM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AllRoomsViewController: UIViewController {
    let db = Firestore.firestore()
    var roomsCollection: [QueryDocumentSnapshot] = []
    var roomName: String?
    var roomDescription: String?
    
    @IBOutlet weak var roomCells: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chat App"
        tableView.delegate = self
        tableView.dataSource = self
        addChannelListener()
    }
    
    @IBOutlet weak var tableView: UITableView!
    func addChannelListener() {
        //Update rooms when new room is added
//        self.roomsCollection = snapshot
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        self.loadAllRooms()
    }
    
    func loadAllRooms() {
        //Load rooms when page appeared
        db.collection("channels").getDocuments { (snapShot, error) in
            if error != nil {
                print(error!)
            } else {
                self.roomsCollection = snapShot!.documents
                self.tableView.reloadData()
            }
        }
    }
}

extension AllRoomsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Numbers of rows to show on UITableView
        return roomsCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // UI to show on each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomCell
        roomName = roomsCollection[indexPath.row].data()["name"] as? String
        roomDescription = roomsCollection[indexPath.row].data()["description"] as? String
        cell.configCell(name: roomName ?? "", description: roomDescription ?? "")
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Tapped on cell
        performSegue(withIdentifier: "toChat", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Set value on next page
        if let destination = segue.destination as? ChatViewController {
            destination.channel = roomName
        }
    }
}

extension AllRoomsViewController: UITableViewDelegate {
    
}
