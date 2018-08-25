//
//  FavViewController.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/21.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit
import SwiftSpinner

class FavViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var didPrevious: UIButton!
    
    @IBOutlet weak var didNext: UIButton!
    
    var type:Int = -1
    var typeName:String = ""
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
        print("FAVORITE:")
        
        loadFavData()
        enablePage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavData()
        enablePage()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavUserTableViewCell") as! FavTableViewCell
            cell.lblFavName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgFavStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgFavStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }
            return cell
        }
        else if( type == 1 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavPageTableViewCell") as! FavTableViewCell
            cell.lblFavName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgFavStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgFavStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }
            return cell
        }
        else if( type == 2 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavEventTableViewCell") as! FavTableViewCell
            cell.lblFavName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgFavStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgFavStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }
            return cell
        }
        else if( type == 3 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavPlaceTableViewCell") as! FavTableViewCell
            cell.lblFavName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgFavStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgFavStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavGroupTableViewCell") as! FavTableViewCell
            cell.lblFavName.text! = dataNameArr[indexPath.row + page*10]
            
            if let url = URL(string:dataImg[indexPath.row + page*10]){
                if let imgData = try? Data(contentsOf: url){
                    cell.imgIcon.image = UIImage(data: imgData)
                }
            }
            
            let key = dataId[indexPath.row + page*10] + String(type)
            if ( UserDefaults.standard.object(forKey: key) == nil) {
                cell.imgFavStar.setImage(UIImage(named: "empty"), for: UIControlState.normal)
            }
            else{
                cell.imgFavStar.setImage(UIImage(named: "filled"), for: UIControlState.normal)
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SwiftSpinner.show("Loading data...")
        
        detailName = dataNameArr[indexPath.row + page*10]
        detailImg = dataImg[indexPath.row + page*10]
        detailId = dataId[indexPath.row + page*10]
        self.performSegue(withIdentifier: "favSague"+String(type), sender: Any?.self)
        
        //print("do select")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("do prepare")
        if ( segue.identifier == "favSague"+String(type) ) {
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
            didPrevious.isHidden = true
        }
        else{
            didPrevious.isHidden = false
        }
        
        if(page >= (dataNameArr.count-1)/10){
            didNext.isHidden = true
        }
        else{
            didNext.isHidden = false
        }
    }
    
    func loadFavData(){
        if(type == 0){
            typeName = "user"
            print("FAVORITE: " + typeName)
            
            if ( UserDefaults.standard.object(forKey: typeName) != nil){
                
                // load key(id+type) from Type
                let typeKeyArr = UserDefaults.standard.object(forKey: typeName) as! [String]
                
                dataNameArr = Array(repeating: "", count: typeKeyArr.count)
                dataImg = Array(repeating: "", count: typeKeyArr.count)
                dataId = Array(repeating: "", count: typeKeyArr.count)
                // load [,id,name,img] by key(id+type)
                var index = 0
                for itemKey in typeKeyArr{
                    let array = UserDefaults.standard.object(forKey: itemKey) as! Array<String>
                    print(array)
                    dataId[index] = array[1]
                    dataNameArr[index] = array[2]
                    dataImg[index] = array[3]
                    index += 1
                }
            }
            
        }
        else if(type == 1){
            typeName = "page"
            print("FAVORITE: " + typeName)
            
            if ( UserDefaults.standard.object(forKey: typeName) != nil){
                
                // load key(id+type) from Type
                let typeKeyArr = UserDefaults.standard.object(forKey: typeName) as! [String]
                
                dataNameArr = Array(repeating: "", count: typeKeyArr.count)
                dataImg = Array(repeating: "", count: typeKeyArr.count)
                dataId = Array(repeating: "", count: typeKeyArr.count)
                // load [,id,name,img] by key(id+type)
                var index = 0
                for itemKey in typeKeyArr{
                    let array = UserDefaults.standard.object(forKey: itemKey) as! Array<String>
                    print(array)
                    dataId[index] = array[1]
                    dataNameArr[index] = array[2]
                    dataImg[index] = array[3]
                    index += 1
                }
            }
        }
        else if(type == 2){
            typeName = "event"
            print("FAVORITE: " + typeName)
            
            if ( UserDefaults.standard.object(forKey: typeName) != nil){
                
                // load key(id+type) from Type
                let typeKeyArr = UserDefaults.standard.object(forKey: typeName) as! [String]
                
                dataNameArr = Array(repeating: "", count: typeKeyArr.count)
                dataImg = Array(repeating: "", count: typeKeyArr.count)
                dataId = Array(repeating: "", count: typeKeyArr.count)
                // load [,id,name,img] by key(id+type)
                var index = 0
                for itemKey in typeKeyArr{
                    let array = UserDefaults.standard.object(forKey: itemKey) as! Array<String>
                    print(array)
                    dataId[index] = array[1]
                    dataNameArr[index] = array[2]
                    dataImg[index] = array[3]
                    index += 1
                }
            }
        }
        else if(type == 3){
            typeName = "place"
            print("FAVORITE: " + typeName)
            
            if ( UserDefaults.standard.object(forKey: typeName) != nil){
                
                // load key(id+type) from Type
                let typeKeyArr = UserDefaults.standard.object(forKey: typeName) as! [String]
                
                dataNameArr = Array(repeating: "", count: typeKeyArr.count)
                dataImg = Array(repeating: "", count: typeKeyArr.count)
                dataId = Array(repeating: "", count: typeKeyArr.count)
                // load [,id,name,img] by key(id+type)
                var index = 0
                for itemKey in typeKeyArr{
                    let array = UserDefaults.standard.object(forKey: itemKey) as! Array<String>
                    print(array)
                    dataId[index] = array[1]
                    dataNameArr[index] = array[2]
                    dataImg[index] = array[3]
                    index += 1
                }
            }
        }
        else if(type == 4){
            typeName = "group"
            print("FAVORITE: " + typeName)
            
            if ( UserDefaults.standard.object(forKey: typeName) != nil){
                
                // load key(id+type) from Type
                let typeKeyArr = UserDefaults.standard.object(forKey: typeName) as! [String]
                
                dataNameArr = Array(repeating: "", count: typeKeyArr.count)
                dataImg = Array(repeating: "", count: typeKeyArr.count)
                dataId = Array(repeating: "", count: typeKeyArr.count)
                // load [,id,name,img] by key(id+type)
                var index = 0
                for itemKey in typeKeyArr{
                    let array = UserDefaults.standard.object(forKey: itemKey) as! Array<String>
                    print(array)
                    dataId[index] = array[1]
                    dataNameArr[index] = array[2]
                    dataImg[index] = array[3]
                    index += 1
                }
            }
            
        }

    }

}
