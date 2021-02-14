//
//  CalendarController.swift
//  pon
//
//  Created by Demir Dazdarevic on 11.2.21..
//

import Foundation
import UIKit
import Lottie
import KDCalendar

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
        
    }
    
   
 
    
}

protocol CalendarViewDataSource {
    func startDate() -> NSDate // UTC Date
    func endDate() -> NSDate   // UTC Date
}
protocol CalendarViewDelegate {
    func calendar(_ calendar : CalendarView, canSelectDate date : Date) -> Bool /* optional */
    func calendar(_ calendar : CalendarView, didScrollToMonth date : Date) -> Void
    func calendar(_ calendar : CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) -> Void
    func calendar(_ calendar : CalendarView, didDeselectDate date : Date) -> Void /* optional */
    func calendar(_ calendar : CalendarView, didLongPressDate date : Date, withEvents events: [CalendarEvent]?) -> Void /* optional */
}
