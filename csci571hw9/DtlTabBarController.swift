//
//  DtlTabBarController.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/18.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit
import EasyToast
import FBSDKShareKit

class DtlTabBarController: UITabBarController,FBSDKSharingDelegate {
    
    var typeName:String = ""
    var type:Int = -1
    var detailId:String = ""
    var detailName:String = ""
    var detailImg:String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = "Results"


        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func btnAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Menu", preferredStyle: .actionSheet)
        
        let keyValue: String = detailId + String(type) // key: ID + type
        let favOption = showFavOption( key: keyValue)
        
        
        let favoriteAction = UIAlertAction(title: favOption, style: .default){ action in
            self.fav( key: keyValue)
            
            if ( UserDefaults.standard.object(forKey: self.typeName) != nil){
                print( UserDefaults.standard.object(forKey: self.typeName)!  )
            }
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default){ action in
            let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
            content.contentTitle = self.detailName
            content.contentDescription = "FB Share for CSCI 571"
            content.imageURL = URL(string: self.detailImg)
            
            let shareDialog: FBSDKShareDialog = FBSDKShareDialog()
            shareDialog.shareContent = content
            shareDialog.delegate = self
            shareDialog.fromViewController = self
            shareDialog.mode = .feedBrowser
//            if !shareDialog.canShow() {
//                // fallback to non-native mode
//                shareDialog.mode = .feedBrowser
//            }
            shareDialog.show()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){ action in
            
        }
        alertController.addAction(favoriteAction)
        alertController.addAction(shareAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        self.view.showToast("Shared!", position: .bottom, popTime: 2, dismissOnTap: false)
        print(results)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print("FB: sharer Error")
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        self.view.showToast("Canceled!", position: .bottom, popTime: 2, dismissOnTap: false)
        print("FB: share did cancel")
    }
    
    
    func showFavOption( key: String) -> String {
        if ( UserDefaults.standard.object(forKey: key) == nil) {
            return "Add to favorites"
        }
        else{
            return "Remove from favorites"
        }
    }
    
    func fav( key: String){
        print("do FAVVV")
        
        if ( UserDefaults.standard.object(forKey: typeName) == nil){
            print("fav: build key = " + typeName)
            let emptyArr:Array = [String]()
            UserDefaults.standard.set( emptyArr, forKey: typeName)
            UserDefaults.standard.synchronize()
        }
        
        // Add  if notExist
        if( UserDefaults.standard.object(forKey: key) == nil ){
            // 1) set key(id+type) to Type
            var typeKeyArr:Array = [String]()
            typeKeyArr = UserDefaults.standard.object(forKey: typeName) as! [String]
            typeKeyArr.append(key)
            print("fav: add  (1)")
            print(typeKeyArr)
            UserDefaults.standard.set( typeKeyArr , forKey: typeName)
            UserDefaults.standard.synchronize()
            
            // 2) set 4 data to key(id+type)
            let array:Array = [String(type), detailId, detailName, detailImg] as [Any] // type, id, name, img
            print("fav: add  (2)")
            print(array)
            UserDefaults.standard.set(array, forKey: key)
            UserDefaults.standard.synchronize()
            
            self.view.showToast("Added to favorites!", position: .bottom, popTime: 2, dismissOnTap: false)
        }
        // Remove  else exist
        else{
            // 1) remove key(id+type) from Type
            var typeKeyArr:Array = [String]()
            typeKeyArr = UserDefaults.standard.object(forKey: typeName) as! [String]
            if let index = typeKeyArr.index(of: key){
                typeKeyArr.remove(at: index)
            }
            print("fav: remove  (1)")
            print(typeKeyArr)
            UserDefaults.standard.set( typeKeyArr, forKey: typeName)
            UserDefaults.standard.synchronize()
            
            // 2) set 4 data from key(id+type)
            print("fav: remove  (2)")
            UserDefaults.standard.removeObject(forKey: key)
            
            self.view.showToast("Removed from favorites!", position: .bottom, popTime: 2, dismissOnTap: false)
        }
    }

}
