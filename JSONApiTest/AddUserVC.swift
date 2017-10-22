//
//  AddUserVC.swift
//  JSONApiTest
//
//  Created by George Davies on 22/10/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit

class AddUserVC: NetworkingController {
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var isOverheadSwitch: UISwitch!
    @IBOutlet weak var jobTitleTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTxtField.text = "George"
        lastNameTxtField.text = "Davies"
        emailTxtField.text = "1@1.com"
        jobTitleTxtField.text = "BA"
    }
    
    @IBAction func saveChanges(sender: UIButton) {
        createNewEntity(entityType: "users", entity: User(id: nil, firstName: firstNameTxtField.text, lastName: lastNameTxtField.text, email: emailTxtField.text, isOverhead: isOverheadSwitch.isOn, jobTitle: jobTitleTxtField.text))
        self.dismiss(animated: true, completion: nil)
    }
}
