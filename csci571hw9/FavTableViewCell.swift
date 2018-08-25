//
//  FavTableViewCell.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/21.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lblFavName: UILabel!
    
    @IBOutlet weak var imgFavStar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
