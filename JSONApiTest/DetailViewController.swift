//
//  DetailTableViewController.swift
//  JSONApiTest
//
//  Created by George Davies on 16/10/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedUser: User?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "\(selectedUser!.firstName) \(selectedUser!.lastName)"
        case 1:
            cell.textLabel?.text = selectedUser?.jobTitle
        case 2:
            cell.textLabel?.text = selectedUser?.email
        case 3:
            cell.textLabel?.text = "Is overhead? \(String(describing: selectedUser!.isOverhead))"
        default:
            cell.textLabel?.text = ""
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
