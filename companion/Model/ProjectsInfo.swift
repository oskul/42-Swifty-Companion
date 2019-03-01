//
//  ProjectsInfo.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/7/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProjectsInfo: SectionProtocol {
    var projects : [String]?
    
    var type: SectionType {
        return .projects
    }
    
    var sectionTitle: String {
        return "Projects"
    }
    
    var rowCount: Int {
        if let proj = projects {
            return proj.count
        } else {
            return 0
        }
    }
    
    init(for data: JSON) {
        
        // TODO: Add check for nil in data["projects_users"]. Data["projects_users"] can be nil
        
        for project in data["projects_users"] {
            if project.1["status"] == "finished" {
                if project.1["project"]["slug"].string!.lowercased().range(of:"piscine") == nil || project.1["project"]["name"].string!.lowercased().range(of:"piscine") != nil {
                    if project.1["project"]["name"] != JSON.null && project.1["final_mark"] != JSON.null {
                        let result = ("\(project.1["project"]["name"]) - \(project.1["final_mark"])%")
                        if (projects?.append(result)) == nil {
                            projects = [result]
                        }
                    }
                }
            }
        }
    }
}
