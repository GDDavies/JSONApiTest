//
//  Models.swift
//  JSONApiTest
//
//  Created by George Davies on 21/10/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import Foundation

struct Users {
    var users: [User]
    
    init(json: [[String:Any]]) {
        var usersArray = [User]()
        for user in json {
            if let id = user["id"] as? Int,
            let firstName = user["first_name"] as? String,
            let lastName = user["last_name"] as? String,
            let email = user["email"] as? String,
            let isOverhead = user["is_overhead"] as? Bool,
            let jobTitle = user["job_title"] as? String {
                let newUser = User(id: id, firstName: firstName, lastName: lastName, email: email, isOverhead: isOverhead, jobTitle: jobTitle)
                usersArray.append(newUser)
            }
        }
        self.users = usersArray
    }
}

struct User {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var isOverhead: Bool?
    var jobTitle: String?
}

struct Projects {
    var projects: [Project]
    
    init(json: [[String:Any]]) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var projectsArray = [Project]()
        for project in json {
            if let id = project["id"] as? Int,
            let projectName = project["project_name"] as? String,
            let projectCode = project["project_code"] as? String,
            let hasWarrant = project["has_warrant"] as? Bool,
            let gatePassed = project["gate_passed"] as? Int,
            let isCapitalProject = project["is_capital_project"] as? Bool,
            let startDate = project["start_date"] as? String,
            let endDate = project["end_date"] as? String {
                let newProject = Project(id: id, projectName: projectName, projectId: projectCode, hasWarrant: hasWarrant, gatePassed: gatePassed, isCapitalProject: isCapitalProject, startDate: formatter.date(from: startDate)!, endDate: formatter.date(from: endDate)!)
                projectsArray.append(newProject)
            }
        }
        self.projects = projectsArray
    }
    static let endpoint = URL(string: "http://localhost:3000/api/v1/projects/")!
}

struct Project {
    var id: Int
    var projectName: String
    var projectId: String
    var hasWarrant: Bool
    var gatePassed: Int
    var isCapitalProject: Bool
    var startDate: Date
    var endDate: Date
}

let keys = [
    "id": "id",
    "firstName" : "first_name",
    "lastName" : "last_name",
    "email" : "email",
    "isOverhead" : "is_overhead",
    "jobTitle" : "job_title"
]
