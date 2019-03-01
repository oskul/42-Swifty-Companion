//
//  TableViewController.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import ChameleonFramework

class TableViewController: UITableViewController {
    var sections : [SectionProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.estimatedRowHeight = 20
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        tableView?.register(InfoTableViewCell.nib, forCellReuseIdentifier: InfoTableViewCell.identifier)
        tableView?.register(SkillsTableViewCell.nib, forCellReuseIdentifier: SkillsTableViewCell.identifier)
        tableView?.register(ProjectsTableViewCell.nib, forCellReuseIdentifier: ProjectsTableViewCell.identifier)
        
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowCount
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections[section].rowCount != 0 {
            let label : UILabel = UILabel()
            label.text = sections[section].sectionTitle
            label.textColor = UIColor.white
            if sections[section].type == .main {
                label.backgroundColor = UIColor.flatGray
            } else if sections[section].type == .skills {
                label.backgroundColor = UIColor.flatSkyBlue
            } else if sections[section].type == .projects {
                label.backgroundColor = UIColor.flatTeal
            }
            return label
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section.type {
        case .main:
            if let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell {
                let item = sections[indexPath.section] as! MainSectionInfo
                cell.profileImage.image = item.img
                cell.name.text = item.name
                cell.login.text = item.login
                cell.phone.text = item.phone
                cell.wallet.text = item.wallet
                cell.correction.text = item.corrections
                cell.level.text = item.levelText
                cell.progressView.progress = item.levelValue / 21
                
                return cell
            }
        case .skills:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.identifier, for: indexPath) as? SkillsTableViewCell {
                let item = sections[indexPath.section] as! SkillsInfo
                cell.skill.text = item.skillsTextArray?[indexPath.row]
                cell.progressBar.progress = (item.skillsValuesArray?[indexPath.row])! / 21
                
                return cell
            }
        case .projects:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProjectsTableViewCell.identifier, for: indexPath) as? ProjectsTableViewCell {
                let item = sections[indexPath.section] as! ProjectsInfo
                cell.project.text = item.projects?[indexPath.row]
                
                return cell
            }
        }
        return UITableViewCell()
    }
}


