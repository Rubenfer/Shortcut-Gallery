//
//  GalleryTableViewCell.swift
//  Shortcuts Gallery
//
//  Created by Marco Capano on 09/07/2018.
//  Copyright © 2018 Marco Capano. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var box: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        box.sizeToFit()
        
        box.layer.shadowColor = UIColor(red: 151/255, green: 170/255, blue: 186/255, alpha: 0.5).cgColor
        box.layer.shadowRadius = 14.0
        box.layer.shadowOffset = CGSize(width: 0, height: 3)
        box.layer.shadowOpacity = 1.0
        box.layer.cornerRadius = 14
        box.layer.masksToBounds = false
    }
    
}
