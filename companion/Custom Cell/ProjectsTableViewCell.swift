//
//  ProjectsTableViewCell.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    @IBOutlet weak var project: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        print(ProjectsTableViewCell.identifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
