//
//  MenuViewController.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/15.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var menuNameArr:Array = [[String]]()
    var menuNameHeader:Array = [String]()
    var iconImage:Array = [[UIImage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuNameArr = [["FB Search"],["Home","Favorite"],["About me"]]
        menuNameHeader = ["","MENU","OTHERS"]
        iconImage = [[UIImage(named:"fb")!],[UIImage(named:"home")!,UIImage(named:"favorite")!]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(indexPath.section, indexPath.row)
        if (indexPath.section < 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
            cell.imgIcon.image = iconImage[indexPath.section][indexPath.row]
            cell.lblMenuName.text! = menuNameArr[indexPath.section][indexPath.row]
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell_AboutMe") as! MenuTableViewCell_AboutMe
            
            cell.lblMenuName.text! = menuNameArr[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuNameHeader[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat
        
        switch section {
        case 0:
            // hide the header
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 32
        }
        
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        
        if (indexPath.section < 2){
            let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
            if cell.lblMenuName.text! == "Home"
            {
                let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            }
        
            if cell.lblMenuName.text! == "Favorite"
            {
                let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryboard.instantiateViewController(withIdentifier: "FavTabBarController") as! FavTabBarController

                for i in 0...4{
                    //print(i)
                    let navigate = desController.viewControllers![i] as! UINavigationController
                    let viewCtrlr = navigate.viewControllers[0] as! FavViewController
                    viewCtrlr.type = i
                }
            
                revealViewController.pushFrontViewController(desController, animated: true)
            }
        }
        else if (indexPath.section == 2){
            
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "AbtViewController") as! AbtViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)


        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
