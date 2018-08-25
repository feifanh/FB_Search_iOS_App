//
//  SrhViewController.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/17.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftSpinner


class SrhViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var didPrevious: UIButton!
    
    @IBOutlet weak var didNext: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    
    var str:String = ""
    
    var type:Int = -1
    var typeName:String = ""
    var data:JSON = []
    var page:Int = 0
    
    var dataNameArr:Array = [String]()
    var dataImg:Array = [String]()
    var dataId:Array = [String]()
    
    var detailName:String = ""
    var detailImg:String = ""
    var detailId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()

        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        // Do any additional setup after loading the view.
        
        
        print("here: " + str)
        print(type)
        
        if(type == 0){
            typeName = "user"
            dataNameArr = data["user"]["data"].arrayValue.map({$0["name"].stringValue})
            dataImg = data["user"]["data"].arrayValue.map({$0["picture"]["data"]["url"].stringValue})
            dataId = data ["user"]["data"].arrayValue.map({$0["id"].stringValue})
            
            if ( UserDefaults.standard.object(forKey: typeName) == nil){
                let emptyArr:Array = [String]()
                UserDefaults.standard.set( emptyArr, forKey: typeName)
            }
        }
        else if(type == 1){
            SwiftSpinner.show("Loading data...")
            typeName = "page"
            dataNameArr = data["page"]["data"].arrayValue.map({$0["name"].stringValue})
            dataImg = data["page"]["data"].arrayValue.map({$0["picture"]["data"]["url"].stringValue})
            dataId = data ["page"]["data"].arrayValue.map({$0["id"].stringValue})
            
            
        }
        else if(type == 2){
            SwiftSpinner.show("Loading data...")
            typeName = "event"
            dataNameArr = data["event"]["data"].arrayValue.map({$0["name"].stringValue})
            dataImg = data["event"]["data"].arrayValue.map({$0["picture"]["data"]["url"].stringValue})
            dataId = data ["event"]["data"].arrayValue.map({$0["id"].stringValue})

        }
        else if(type == 3){
            SwiftSpinner.show("Loading data...")
            typeName = "place"
            dataNameArr = data["place"]["data"].arrayValue.map({$0["name"].stringValue})
            dataImg = data["place"]["data"].arrayValue.map({$0["picture"]["data"]["url"].stringValue})
            dataId = data ["place"]["data"].arrayValue.map({$0["id"].stringValue})

        }
        else if(type == 4){
            SwiftSpinner.show("Loading data...")
            typeName = "group"
            dataNameArr = data["group"]["data"].arrayValue.map({$0["name"].stringValue})
            dataImg = data["group"]["data"].arrayValue.map({$0["picture"]["data"]["url"].stringValue})
            dataId = data ["group"]["data"].arrayValue.map({$0["id"].stringValue})
            
            
            
        }

        SwiftSpinner.hide()
        enablePage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // data Arr less than 10
        if (dataNameArr.count < 10){
            return dataNameArr.count
        }
        // dataNameArr.count >=10 & not the last page
        else if (page < (dataNameArr.count-1)/10){
            return 10
        }
        // dataNameArr.count >=10 & the last page
        else{
            return dataNameArr.count - page*10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(type==0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SrhUserTableViewCell") as! SrhTableViewCell
            cell.lblSrhName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgSrhStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgSrhStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }
            
            
            return cell
        }
        else if(type==1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SrhPageTableViewCell") as! SrhTableViewCell
            cell.lblSrhName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgSrhStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgSrhStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }

            
            return cell
        }
        else if(type==2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SrhEventTableViewCell") as! SrhTableViewCell
            cell.lblSrhName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgSrhStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgSrhStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }

            
            return cell
        }
        else if(type==3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SrhPlaceTableViewCell") as! SrhTableViewCell
            cell.lblSrhName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgSrhStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgSrhStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }

            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SrhGroupTableViewCell") as! SrhTableViewCell
            cell.lblSrhName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgSrhStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgSrhStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }

            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SwiftSpinner.show("Loading data...")
        
        detailName = dataNameArr[indexPath.row + page*10]
        detailImg = dataImg[indexPath.row + page*10]
        detailId = dataId[indexPath.row + page*10]
        self.performSegue(withIdentifier: "srhSague"+String(type), sender: Any?.self)

        //print("do select")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("do prepare")
        if ( segue.identifier == "srhSague"+String(type) ) {
            let tabBarController:DtlTabBarController = segue.destination as! DtlTabBarController
            tabBarController.typeName = typeName
            tabBarController.type = type
            tabBarController.detailId = detailId
            tabBarController.detailName = detailName
            tabBarController.detailImg = detailImg
            
            // album
            let albmVC = tabBarController.viewControllers?[0] as! AlbmViewController
            albmVC.type = type
            albmVC.typeName = typeName // for PHP searching
            albmVC.detailId = detailId // for PHP searching
            //albmVC.detailName = detailName
            //albmVC.detailImg = detailImg
            
            
            // post
            let postVC = tabBarController.viewControllers?[1] as! PostViewController
            postVC.type = type
            postVC.typeName = typeName     // for PHP searching
            postVC.detailName = detailName // for PHP searching
            postVC.detailImg = detailImg
            postVC.detailId = detailId
            
            
        }
    }


    
    @IBAction func didPrevious(_ sender: Any) {
        page -= 1
        tblView.reloadData()
        enablePage()
    }

    @IBAction func didNext(_ sender: Any) {
        page += 1
        tblView.reloadData()
        enablePage()
    }
    
    
    
    func enablePage(){
        if(page == 0){
            didPrevious.isEnabled = false
        }
        else{
            didPrevious.isEnabled = true
        }
        
        if(page >= (dataNameArr.count-1)/10){
            didNext.isEnabled = false
        }
        else{
            didNext.isEnabled = true
        }
    }


}
