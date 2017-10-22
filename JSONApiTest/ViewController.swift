//
//  ViewController.swift
//  JSONApiTest
//
//  Created by George Davies on 15/10/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit

class ViewController: NetworkingController, UITableViewDelegate, UITableViewDataSource {

    var selectedIndex: Int?
    
    var users = [User]()
    var projects = [Project]()
    
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEntities(entityType: "users")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllEntities(entityType: "users")
    }
    
    override func receivedData(data: AnyObject?) {
        if let json = data as? [[String:Any]] {
            self.users = Users(json: json).users
            OperationQueue.main.addOperation {
                self.usersTableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        //return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].firstName
        //cell.textLabel?.text = projects[indexPath.row].projectName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteEntity(entityType: "users", entityId: users[indexPath.row].id!)
            users.remove(at: indexPath.row)
            OperationQueue.main.addOperation {
                self.usersTableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let index = self.selectedIndex {
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.selectedUser = users[index]
            }
        }
    }
}

