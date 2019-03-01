//
//  ViewController.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController {
    let UID : String = "da5c4900e4abcd452b21838514334b39ccc03c23d5bd17e18f1f149de78c23e2"
    let SECRET : String = "388154521cdfd3916ca56a24f494390659478b01d8817bbc0092d1fbdff247c7"
    let URL : String = "https://api.intra.42.fr"
    let AUTH_LINK : String = "/oauth/token"
    let USER_LINK : String = "/v2/users/"
    var TOKEN : String = ""
    var tokenExpire : Double = 0
    var json : JSON?
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonView: UIButton!
    
    @IBAction func searchButton(_ sender: UIButton) {
        buttonView.isEnabled = false
        let login = textField.text!
        if !login.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            searchAndShowUserData(for: textField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
            showAlert(title: "Empty Search Field", message: "Please, enter user login")
            buttonView.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    
    func getToken() {
        Alamofire.request(URL + AUTH_LINK, method: .post, parameters: ["grant_type" : "client_credentials", "client_id" : UID, "client_secret" : SECRET]).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Connection Validation Successful")
                self.json = JSON(response.value!)
                self.TOKEN = self.json!["access_token"].string!
                self.tokenExpire = self.json!["created_at"].double! + self.json!["expires_in"].double!
            case .failure(let error):
                print(error)
                self.tryAgainAlert()
            }
        }
    }
    
    func searchAndShowUserData(for login : String) {
        SVProgressHUD.show()
        
        if (NSDate().timeIntervalSince1970 > tokenExpire) {
            self.getToken()
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(self.TOKEN)"]
        Alamofire.request(URL + USER_LINK + login, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                print("Success")
                self.json = JSON(response.value!)
                if (self.json?.isEmpty)! {
                    self.showAlert(title: "No Such Login", message: "This login is invalid. Please try new one")
                }
                SVProgressHUD.dismiss()
                self.buttonView.isEnabled = true
                self.performSegue(withIdentifier: "showDataSegue", sender: self)
            case .failure(let error):
                print(error)
                
                SVProgressHUD.dismiss()
                self.showAlert(title: "Invalid Login", message: "Please enter just one word")
                self.buttonView.isEnabled = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDataSegue" {
            let destinationVC = segue.destination as! TableViewController
            
            destinationVC.sections.append(MainSectionInfo(for: json!))
            destinationVC.sections.append(SkillsInfo(for: json!))
            destinationVC.sections.append(ProjectsInfo(for: json!))
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            return
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tryAgainAlert() {
        let alert = UIAlertController(title: "API Connection Problem", message: "Please check your internet connection and your token", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.getToken()
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

