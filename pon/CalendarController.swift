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
    @IBOutlet weak var kalendar: UIDatePicker!
    @IBOutlet weak var problem: UILabel!
    @IBOutlet weak var fullfiled: UILabel!
    
    @IBOutlet weak var medal: UIView!
    
    var freshLaunch = true
    private var lottie:LottieView?
    private var animationView:AnimationView = .init(name: "bronze")
    
    struct calen: Decodable {
        let C1: Int
        let C2: Int
        let C3: Int
        let C4: Int
        let C5: Int
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
       
        
        if freshLaunch == true {
          
           
            freshLaunch = false
           self.tabBarController!.selectedIndex = 2
           //self.tabBarController!.tabBar.shadowImage = nil
           
          
        }
        super.viewDidAppear(animated)
            }
    
    override func viewDidLoad() {
        
        //calendar.dataSource = self
        //view.addSubview(calendar)
       
        
        super.viewDidLoad()
        self.showSideMenu()
        kalendar.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
    
        
        animationView.frame = .init(x: medal.bounds.midX - 40, y: 0, width: 60, height: 70)
        // 3. Set animation content mode
        
        animationView.contentMode = .scaleAspectFit
        
        
        // 4. Set animation loop mode
        
        animationView.loopMode = .autoReverse
        
        // 5. Adjust animation speed
        
        animationView.animationSpeed = 0.5
        
        self.medal.addSubview(animationView)
        
        //prikaz animacijes
        // 2. Start AnimationView with animation name (without extension)
        //animationView!.play()
        animationView.isHidden = true
       
        
        }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        
       // if(picker.date < 9)
        let preferences = UserDefaults.standard
        // let components = Calendar.current.dateComponents([.day, .month], from: picker.date)
       // let day = components.day!
        //let month = components.month!
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy/MM/dd"
        
       // if components.month! < 9 {
            var result = Data()
            var resultString = "null"
            let nakomp:String = formatter.string(from: picker.date)
            
            let url = URL(string: "https://webapi20210118170049.azurewebsites.net/api/calendar/?id=\(preferences.string(forKey: "email") ?? "")&date=\(nakomp)")!
            //SEMAFOR DA CEKA DA SE GET URADI
            let sem = DispatchSemaphore(value: 0)
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                result = data
                resultString = String(data: data, encoding: .utf8)!
                
              
                sem.signal()
            }

        task.resume()
        sem.wait()
        if (resultString != "null") {
            let json = try! JSONDecoder().decode(calen.self, from: result)
            let percentageg = self.percentage(first: json.C1, second: json.C2, third: json.C3, fourth: json.C4, fifth: json.C5)
            //catch { print(Error)}
            self.fullfiled.text = "\(String(percentageg)) %"
           // self.problem.text = "ima problema"
            problematic(first: json.C1, second: json.C2, third: json.C3, fourth: json.C4, fifth: json.C5)
            self.medalChange(percentage: percentageg)
       
         //tri promene
       
            
           
            }
        else {
            self.problem.text = "No Record"
            self.fullfiled.text = "No Record"
            self.animationView.isHidden = true
        }
        
    }
    
    
    func percentage(first:Int,second: Int,third: Int,fourth: Int,fifth: Int) -> Int {
            let ukupno = first+second+third+fourth+fifth
            let percentage = (Double(ukupno)/17) * 100
            let rounded = Int(percentage)
            return rounded
        }
    
    func medalChange(percentage:Int){

        if(percentage<=50){
        
            self.animationView.animation = Animation.named("bronze")
            self.animationView.isHidden = false
            self.animationView.play()
        }
        else if(percentage>50 && percentage<=70){
            self.animationView.animation = Animation.named("silver")
            self.animationView.isHidden = false
            self.animationView.play()}
        else if(percentage>70 && percentage<=85){
            self.animationView.animation = Animation.named("gold")
            self.animationView.isHidden = false
            self.animationView.play()}
        else if(percentage>85 && percentage<=100){
            self.animationView.animation = Animation.named("diamond")
            self.animationView.isHidden = false
            self.animationView.play()}
    }
    
    func problematic(first:Int,second: Int,third: Int,fourth: Int,fifth: Int) {



       // var green:String = "<font color='#4CAF50'>"
        //       var yellow:String  = "<font color='#FFEB3B'>"
         //      var red:String  = "<font color='B50000'>"
          //     var fontend:String  = "</font>"
           //    var wholehtml:String = ""
               var fiz = ""
               var sec = ""
               var thi = ""
               var fort = ""
               var fiv = ""
              

        if(first<4){
            fiz = "<font color='#B50000'>Fiziološke</font>,"  }
        if(first==4 || first==5){
            fiz = "<font color='#FFEB3B'>Fiziološke</font>,"}
        if(first==6){
                   fiz = "<font color='#4CAF50'>Fiziološke</font>,"
        }
        if(second<2){
            sec = "<font color='#B50000'> Sigurnosne</font>," }
        if(second==2) {
            sec = "<font color='#FFEB3B'> Sigurnosne</font>," }
        if(second==3) {
            sec = "<font color='#4CAF50'> Sigurnosne</font>,"}

        if(third<2) {
            thi = "<font color='#B50000'> Pripadanje</font>," }
        if(third==2) {
                   thi = "<font color='#FFEB3B'> Pripadanje</font>,"
        }
        if(fourth<1) {
            fort = "<font color='#B50000'> Poštovanje</font>," }
        if(fourth==1) {
            fort = "<font color='#FFEB3B'> Poštovanje</font>," }

        if(fifth<1) {
                   fiv = "<font color='#B50000'> Samoaktuelizacija</font>"
        }
        if(("\(fiz)\(sec)\(thi)\(fort)\(fiv)")=="")  { problem.text =  "none" }
        else {
        
        let Html = "\(fiz)\(sec)\(thi)\(fort)\(fiv)"

            self.problem.attributedText = Html.htmlToAttributedString }

    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
/*
 date = year.toString() + "-0" + (month + 1).toString() + "-" + dayOfMonth
 else date= year.toString() + "-" + (month + 1).toString() + "-" + dayOfMonth
 var izabrani: LocalDate = LocalDate.parse(date)
 val jsonURL = "http://10.0.2.2:44386/api/calendar/" + "?id=" + pref.getString(
     "email",
     null
 ) + "&date=" + izabrani.toString()
 doAsync {
     var result = URL(jsonURL).readText()
     uiThread {
         if (result != "null") {
             var jsoni: JSONObject = JSONObject(result)

             var poeni1: Any = jsoni.get("C1")
             var poeni2: Any = jsoni.get("C2")
             var poeni3: Any = jsoni.get("C3")
             var poeni4: Any = jsoni.get("C4")
             var poeni5: Any = jsoni.get("C5")


             fullfilment.text = "Fullfiled:" + percentage(poeni1.toString().toInt(),poeni2.toString().toInt(),poeni3.toString().toInt(),poeni4.toString().toInt(),poeni5.toString().toInt()).toString() + "%"
             problematic(poeni1.toString().toInt(),poeni2.toString().toInt(),poeni3.toString().toInt(),poeni4.toString().toInt(),poeni5.toString().toInt())
             trophy.text = "Trophy: "
             medal(percentage(poeni1.toString().toInt(),poeni2.toString().toInt(),poeni3.toString().toInt(),poeni4.toString().toInt(),poeni5.toString().toInt()))
             //trophy add one of 4 images
 
       

        
    
}
         
                 
                 */
                   /*
                           }
                           else {
                               fullfilment.text = "Fullfiled :No record"
                               problematic.text = "Problematic needs: No record"
                               trophy.text = "Medal: No record"
                               lottiecal.visibility =View.GONE

                           }
                       }
                   }


               }

           }
*/
        //print(picker.date)
    
        
 


//protocol CalendarViewDataSource {
//   func startDate() -> NSDate // UTC Date
 //   func endDate() -> NSDate   // UTC Date
//}
