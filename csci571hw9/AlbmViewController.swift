//
//  AlbmViewController.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/18.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftSpinner


class AlbmViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var type:Int = -1
    var typeName:String = ""
    var detailName:String = ""
    var detailImg:String = ""
    var detailId:String = ""
    
    var albumName:Array = [String]()
    var albumImg:Array = [[String]]()
    var albumHeight:Array = [Int]()
    
    var selectedIndexPath:IndexPath?

    
    @IBOutlet weak var lblNoAlbum: UILabel!
    @IBOutlet weak var tblAlbum: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblAlbum.tableFooterView = UIView()
        print(type)
        print(detailId)
        
        
        Alamofire.request("http://phil-env.us-west-2.elasticbeanstalk.com/fei_asgt8_fan/hw8.php?detail_id="+detailId+"&types="+typeName).responseJSON { response in
            
            if( response.result.value != nil){
                let detailJsonVar = JSON(response.result.value!)
                
                if(detailJsonVar["albums"].exists()){
                    self.lblNoAlbum.isHidden = true
                    self.tblAlbum.isHidden = false
                    
                    //print(detailJsonVar["albums"])
                    // album name
                    self.albumName = detailJsonVar["albums"].arrayValue.map({$0["name"].stringValue})
                    
                    // album images
                    self.albumImg = Array(repeating: Array(repeating: "", count: 2), count: detailJsonVar["albums"].count)
                    self.albumHeight = Array(repeating: 0, count: detailJsonVar["albums"].count)

                    for (key_pho, subJson_pho) in detailJsonVar["albums"] {
                        for (key_pic, subJson_pic) in subJson_pho["photos"] {
                            if let pic = subJson_pic["picture"].string{
                                self.albumImg[Int(key_pho)!][Int(key_pic)!] = pic
                            }
                        }
                        self.albumHeight[Int(key_pho)!] = subJson_pho["photos"].count
                    }
                    
                    self.tblAlbum.reloadData()
                }
                else{
                    self.lblNoAlbum.isHidden = false
                    self.tblAlbum.isHidden = true
                }
            }
            SwiftSpinner.hide()
        }

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbmTableViewCell", for: indexPath) as! AlbmTableViewCell
        cell.lblAlbumTitle.text = albumName[indexPath.row]
        
        if (albumHeight[indexPath.row] == 2) {
            if let url = URL(string:albumImg[indexPath.row][0]) {
                if let imgData = try? Data(contentsOf: url) {
                    cell.imgAlbum1.image = UIImage(data: imgData)
                }
            }
            if let url = URL(string:albumImg[indexPath.row][1]) {
                if let imgData = try? Data(contentsOf: url) {
                    cell.imgAlbum2.image = UIImage(data: imgData)
                }
            }
        }
        else if (albumHeight[indexPath.row] == 1) {
            if let url = URL(string:albumImg[indexPath.row][0]) {
                if let imgData = try? Data(contentsOf: url) {
                    cell.imgAlbum1.image = UIImage(data: imgData)
                }
            }
            // need to hide or not??
            //cell.imgAlbum2.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath{
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath{
            indexPaths += [previous]
        }
        if let current = selectedIndexPath{
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
    }
//    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        (cell as! AlbmTableViewCell).watchFrameChanges()
//    }
//    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        (cell as! AlbmTableViewCell).ignoreFrameChanges()
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            //self defined height
            if(albumHeight[indexPath.row] == 2){
                return AlbmTableViewCell.expandedHeight
            }
            else if (albumHeight[indexPath.row] == 1){
                return 220
            }
            else{
                return 40
            }
        }
        else{
            return AlbmTableViewCell.defaultHeight
        }
    }

}
