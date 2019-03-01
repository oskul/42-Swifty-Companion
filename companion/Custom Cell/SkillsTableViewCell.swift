//
//  SkillsTableViewCell.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var skill: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressBar.layer.cornerRadius = 5
        progressBar.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
