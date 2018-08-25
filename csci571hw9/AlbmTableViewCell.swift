//
//  AlbmTableViewCell.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/19.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit

class AlbmTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAlbumTitle: UILabel!
    @IBOutlet weak var imgAlbum1: UIImageView!
    @IBOutlet weak var imgAlbum2: UIImageView!
    class var expandedHeight: CGFloat {get { return 420 } }
    class var defaultHeight: CGFloat {get { return 40} }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    func checkHeight() {
//        imgAlbum1.isHidden = ( frame.size.height < AlbmTableViewCell.expandedHeight)
//    }
//    
//    func watchFrameChanges() {
//        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
//        checkHeight()
//    }
//    
//    func ignoreFrameChanges() {
//        removeObserver(self, forKeyPath: "frame")
//    }
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "frame" {
//            checkHeight()
//        }
//    }

}
