//
//  ViewController.swift
//  csci571hw9
//
//  Created by Phil Hung on 2017/4/15.
//  Copyright © 2017年 Phil Hung. All rights reserved.
//

import UIKit
import EasyToast
import Alamofire
import SwiftyJSON
import SwiftSpinner

import MapKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var myTextField: UITextField!
    
    let locationManager = CLLocationManager()
    var lat = 0.0
    var long = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))

        
        // For use in background
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            print("work")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            //locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
//        <key>NSLocationAlwaysUsageDescription</key>
//        <key>NSLocationWhenInUseUsageDescription</key>
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        long = userLocation.coordinate.longitude
        lat = userLocation.coordinate.latitude
        print(long)
        print(lat)
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }



    @IBAction func didSearch(_ sender: Any) {
        let inputText = myTextField.text
        
        // No input text
        if(inputText?.isEmpty ?? true){
            self.view.showToast("Enter a valid query!", position: .bottom, popTime: 2, dismissOnTap: false)
            return
        }
        // have input text & do search
        else{
            SwiftSpinner.show("Loading data...")
            print("have text")
            print(String(lat))
            Alamofire.request("http://phil-env.us-west-2.elasticbeanstalk.com/fei_asgt8_fan/hw8.php?keyword="+inputText!.replacingOccurrences(of: " ", with: "+")+"&type=user&lat="+String(lat)+"&long="+String(long)).responseJSON { response in
//                print(response.request!)  // original URL request
//                print(response.response!) // HTTP URL response
//                print(response.data!)     // server data
//                print(response.result)   // result of response serialization
                
                if( response.result.value != nil){
                    let swiftyJsonVar = JSON(response.result.value!)
                    
                    
                    let revealViewController:SWRevealViewController = self.revealViewController()
                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let desController = mainStoryboard.instantiateViewController(withIdentifier: "SrhTabBarController") as! SrhTabBarController
                    
                    for i in 0...4{
                        //print(i)
                        let navigate = desController.viewControllers![i] as! UINavigationController
                        let viewCtrlr = navigate.viewControllers[0] as! SrhViewController
                        viewCtrlr.str = inputText!
                        viewCtrlr.type = i
                        viewCtrlr.data = swiftyJsonVar
                        
                    }
                    //SwiftSpinner.hide()
                    
                    revealViewController.pushFrontViewController(desController, animated: true)
                }
                
                
            }
        }
        
    }
    
    @IBAction func didClear(_ sender: Any) {
        myTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

