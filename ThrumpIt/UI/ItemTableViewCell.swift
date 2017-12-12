//
//  ItemTableViewCell.swift
//  ThrumpIt
//
//  Created by Satish Kumar R Kancherla on 12/2/17.
//  Copyright © 2017 Thrumpit. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    let leftFollowButtonTag = 1001
    let rightFollowButtonTag = 2001
    
    @IBOutlet weak var clImageView: UIImageView!
    @IBOutlet weak var clTitleLabel: UILabel!
    @IBOutlet weak var clDescriptionLabel: UILabel!
    @IBOutlet weak var clLeftImageView: UIImageView!
    @IBOutlet weak var clLeftNameLabel: UILabel!
    @IBOutlet weak var clLeftFollowButton: UIButton!
    @IBOutlet weak var clRightImageView: UIImageView!
    @IBOutlet weak var clRightNameLabel: UILabel!
    @IBOutlet weak var clRightFollowButton: UIButton!

    
    @IBAction func onTappingFollowButton(_ sender: UIButton) {
    }
    
}
