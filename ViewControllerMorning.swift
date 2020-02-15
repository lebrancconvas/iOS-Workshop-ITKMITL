//
//  ViewController.swift
//  WorkshopSample
//
//  Created by Student on 15/2/2563 BE.
//  Copyright © 2563 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let friendName = ["Beam","JoJo","Uno","Zelda","HRK"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topic1") as! UITableViewCell
        cell.textLabel?.text = friendName[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    @IBAction func buttonDid(_ sender: Any) {
        helloLabel.text = "You Says : \(String(describing: nameTextField.text!))"
    }
    
    @IBAction func nextpage(_ sender: Any) {
        performSegue(withIdentifier: "toNextPage", sender: 1)
    }
}

