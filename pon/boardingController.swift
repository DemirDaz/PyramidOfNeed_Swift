//
//  boardingController.swift
//  pon
//
//  Created by Demir Dazdarevic on 13.2.21..
//

import Foundation
import UIKit

class boardingController: UIViewController{
    
    var username:String?
    var pass:String?
    
    override func viewDidLoad() {
    super.viewDidLoad()}
           
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    @IBAction func login(_ sender: Any) {
        
            let preferences = UserDefaults.standard
            preferences.set(1,forKey: "prviput")
            let formatter = DateFormatter()
            let currentDateTime = Date()
            formatter.dateFormat = "yyyy/MM/dd"
            //formatter.dateStyle = .short
            let date:String = formatter.string(from: currentDateTime)

            ///ako je prvi put pokrenuta app
            ///Doesn't exist //dodaj now
            
            preferences.set(date,forKey: "now")
           
            //let newViewController = ViewController()
            //parent?.present(newViewController, animated: true, completion: nil)
        //self.present(newViewController, animated: true, completion: nil)
            //onboardingContainer.removeFromSuperview()
            
        }
    
}
