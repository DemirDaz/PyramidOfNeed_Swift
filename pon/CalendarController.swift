//
//  CalendarController.swift
//  pon
//
//  Created by Demir Dazdarevic on 11.2.21..
//

import Foundation
import UIKit
import Lottie


class CalendarController: UIViewController {
    
    
 
   
    //fileprivate weak var calendar: FSCalendar!
    var freshLaunch = true
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if freshLaunch == true {
          
           
            freshLaunch = false
           self.tabBarController!.selectedIndex = 2
           //self.tabBarController!.tabBar.shadowImage = nil
           
          
        }
            }
    override func viewDidLoad() {
        
        //calendar.dataSource = self
        //view.addSubview(calendar)
       
        
        super.viewDidLoad()
        self.showSideMenu()
        
    }
    
   
 
    
}

protocol CalendarViewDataSource {
    func startDate() -> NSDate // UTC Date
    func endDate() -> NSDate   // UTC Date
}
