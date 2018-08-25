//
//  PostViewController.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/18.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftSpinner

class PostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var type:Int = -1
    var typeName:String = ""
    var detailName:String = ""
    var detailImg:String = ""
    var detailId:String = ""
    
    var detailMsg:Array = [String]()
    var detailStry:Array = [String]()
    var detailTime:Array = [String]()
    
    @IBOutlet weak var lblNoPost: UILabel!
    @IBOutlet weak var tblPost: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Loading data...")
        tblPost.tableFooterView = UIView()
        self.tblPost.estimatedRowHeight = 44.0
        self.tblPost.rowHeight = UITableViewAutomaticDimension
        print(type)
        print(detailName)
        print(detailImg)
        print(detailId)
        
        Alamofire.request("http://phil-env.us-west-2.elasticbeanstalk.com/fei_asgt8_fan/hw8.php?detail_id="+detailId+"&types="+typeName).responseJSON { response in

            
            if( response.result.value != nil){
                let detailJsonVar = JSON(response.result.value!)
                
                if(detailJsonVar["posts"].exists()){
                    self.lblNoPost.isHidden = true
                    self.tblPost.isHidden = false
                    print(detailJsonVar["posts"])
                    self.detailMsg = detailJsonVar["posts"].arrayValue.map({$0["message"].stringValue})
                    self.detailStry = detailJsonVar["posts"].arrayValue.map({$0["story"].stringValue})
                    self.detailTime = detailJsonVar["posts"].arrayValue.map({$0["created_time"]["date"].stringValue})
                    
                    self.tblPost.reloadData()
                }
                else{
                    self.lblNoPost.isHidden = false
                    self.tblPost.isHidden = true
                }
            }
            SwiftSpinner.hide()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailMsg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        if (detailMsg[indexPath.row].isEmpty){
            cell.lblPostMsg.text = detailStry[indexPath.row]
        }
        else{
            cell.lblPostMsg.text = detailMsg[indexPath.row]
        }
        cell.lblPostTime.text = formatDate(date: detailTime[indexPath.row])
        
        if let url = URL(string:detailImg){
            if let imgData = try? Data(contentsOf: url){
                cell.imgIcon.image = UIImage(data: imgData)
            }
        }
        
        
        return cell
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let formattedDate = dateFormatter.date(from: date.components(separatedBy: ".")[0])
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from:formattedDate!)
    }
}
