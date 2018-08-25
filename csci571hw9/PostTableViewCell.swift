//
//  PostTableViewCell.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/20.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lblPostMsg: UILabel!
    
    @IBOutlet weak var lblPostTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
