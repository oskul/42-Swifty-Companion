//
//  InfoTableViewCell.swift
//  companion
//
//  Created by Sergiy SHILINGOV on 11/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import ChameleonFramework

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var correction: UILabel!
    @IBOutlet weak var level: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        profileImage?.layer.cornerRadius = 50
        profileImage?.layer.borderWidth = 2
        profileImage?.layer.borderColor = UIColor.white.cgColor
        profileImage?.clipsToBounds = true
        profileImage?.contentMode = .scaleAspectFit
        profileImage?.backgroundColor = UIColor.flatNavyBlueDark
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
