//
//  SrhTableViewCell.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/18.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit

class SrhTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSrhName: UILabel!

    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var imgSrhStar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
