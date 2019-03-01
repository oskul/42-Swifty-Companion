//
//  SkillsInfo.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/7/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation
import SwiftyJSON

class SkillsInfo: SectionProtocol {
    var skillsTextArray : [String]?
    var skillsValuesArray : [Float]?
    
    var type: SectionType {
        return .skills
    }
    
    var sectionTitle: String {
        return "Skills"
    }
    
    var rowCount: Int {
        if let skills = skillsTextArray {
            return skills.count
        } else {
            return 0
        }
    }
    
    init(for data: JSON) {
        for skill in data["cursus_users"][0]["skills"] {
            if let skillVal = skill.1["level"].float {
                if (skillsValuesArray?.append(skillVal)) == nil {
                    skillsValuesArray = [skillVal]
                }
                let result = ("\(skill.1["name"]) - level \(skill.1["level"])")
                if (skillsTextArray?.append(result)) == nil {
                    skillsTextArray = [result]
                }
            }
        }
    }
}
