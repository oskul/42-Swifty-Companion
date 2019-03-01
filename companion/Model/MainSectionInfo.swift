//
//  MainSectionInfo.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/7/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainSectionInfo: SectionProtocol {
    var img : UIImage = #imageLiteral(resourceName: "profileImage")
    var name : String = "Name: -"
    var login : String = "Login: -"
    var phone : String = "Phone: -"
    var wallet : String = "Wallet: -"
    var corrections : String = "Corrections: -"
    var levelText : String = "Level: -"
    var levelValue : Float = 0.0
    
    var type: SectionType {
        return .main
    }
    
    var sectionTitle: String {
        return "Main"
    }
    
    var rowCount: Int {
        return 1
    }
    
    init(for data: JSON) {
        
        // TODO: Fix this if-else mess with guard somehow
        
        if let imgString = data["image_url"].string {
            let url = URL(string: imgString)
            do {
                let res = try Data(contentsOf: url!)
                if let checkImg = UIImage(data: res) {
                    img = checkImg
                } else {
                    // TODO: Add some standart image. It isn't possible to create image from that Data
                }
            } catch {
                // TODO: Add some standart image. URL is invalid
            }
        } else {
            // TODO: Add some standart image. There is no data in data["image_url"]
        }

        if let checkName = data["displayname"].string {
            name = checkName
        }
        if let checkLogin = data["login"].string {
            login = checkLogin
        }
        if let checkPhone = data["phone"].string {
            phone = checkPhone
        }
        if let checkWallet = data["wallet"].int {
            wallet = "Wallet: \(checkWallet)"
        }
        if let checkCorrections = data["correction_point"].int {
            corrections = "Corrections: \(checkCorrections)"
        }
        
        if let checkLevel = data["cursus_users"][0]["level"].float {
            levelValue = checkLevel
            print(levelValue)
            levelText = "Level: \(checkLevel)%"
        }
    }
}
