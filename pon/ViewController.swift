//
//  ViewController.swift
//  pon
//
//  Created by Demir Dazdarevic on 4.2.21..
//

import UIKit

class ViewController: UIViewController {

   
    
   
    @IBOutlet weak var slikada: UIImageView!
  
    //override func viewWillAppear:(BOOL)animated {
       //super viewWillAppear:animated];
       // You code here to update the view.
    //}
    
    override func viewWillAppear(_ animated: Bool) {
        let preferences = UserDefaults.standard
        changeImage(level: preferences.integer(forKey: "level"))
         }
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        /*
        let someDateTime = formatter.date(from: currentDateTime)
        */
        //Cuvati datum kao string a formatirat kad izadje
        
        ///print(formatter.string(from: currentDateTime))
        let preferences = UserDefaults.standard
        //let currentLevel = 0
        
        if preferences.object(forKey: "now") == nil {
            
            let formatter = DateFormatter()
            let currentDateTime = Date()
            formatter.dateFormat = "yyyy/MM/dd"
            //formatter.dateStyle = .short
            let date:String = formatter.string(from: currentDateTime)

            ///ako je prvi put pokrenuta app
            ///Doesn't exist //dodaj now
            
            preferences.set(date,forKey: "now")
            AddAllActivites()
            
        } else {
            //ako ima now
            let upisani = preferences.string(forKey: "now")!
            let formatter = DateFormatter()
            let currentDateTime = Date()
            formatter.dateFormat = "yyyy/MM/dd"
            //formatter.dateStyle = .short
            let nakomp:String = formatter.string(from: currentDateTime)
            
            ///e sada u date pa uporedi
            
            do{
                let dateup:Date = formatter.date(from: upisani)!
                let datekomp:Date = formatter.date(from: nakomp)!
            if dateup < datekomp {
                //izmeni dan
                preferences.set(nakomp,forKey: "now")
                RemoveAllActivites()
                AddAllActivites()
            }
                
            }
            catch {
                print("Greska kod uporede datuma.")
            }
            
            

            
            
        } }
        
       
               
                /*
                   val date = Date()
                   val sdf = SimpleDateFormat("yyyy-MM-dd")
                   val currentDate:String = sdf.format(date)
                   editor.putString("now",currentDate)
                   editor.apply()
                */
 

    @IBAction func change(_ sender: Any) {
        changeImage(level: 1)
    }
    
    func changeImage(level:Int) {
        if(level==1) {
            slikada.image = UIImage(named: "pyramid1")
            
        }
        else if (level==2) {
            slikada.image = UIImage(named: "pyramid2")
        }
        else if (level==3) {
            slikada.image = UIImage(named: "pyramid3")
        }
        else if (level==4) {
            slikada.image = UIImage(named: "pyramid4")
        }
        else if (level==5) {
            slikada.image = UIImage(named: "pyramid5")
        }
        else if (level==6) {
            slikada.image = UIImage(named: "filled")
        }
    }
    
    
    func AddAllActivites() {
        let preferences = UserDefaults.standard

        //sintaksa upisa
        //preferences.set(currentLevel, forKey: currentLevelKey)
        //fiziologija
        preferences.set("Sedam ili više sati sna.",forKey: "1")
        preferences.set("Doručkovali.",forKey: "2")
        preferences.set("Ručali",forKey: "3")
        preferences.set("Večerali.",forKey: "4")
        preferences.set("Popili dva ili više litra vode.",forKey: "5")
        preferences.set("Bili u toalet.",forKey: "6")
        preferences.set("Sit libido.",forKey: "7")
        


        //sigurnost
        preferences.set("Radni odnos/školovanje.",forKey: "11")
        preferences.set("Finansijska pokrivenost.",forKey: "12")
        preferences.set("Zadovoljavajuće zdravstveno stanje.",forKey: "13")
        preferences.set("Krov nad glavom, dom.",forKey: "14")

        //pripadanje
        preferences.set("Kontaktirati prijatelja.",forKey: "21")
        preferences.set("Kontakt sa porodicom.",forKey: "22")
        preferences.set("Partnerski odnos.",forKey: "23")

        //postovanje
        preferences.set("Osetiti samouverenost.",forKey: "31")
        preferences.set("Doživljaj poštovanja od okoline.",forKey: "32")

        //samo-aktuelizacija
        preferences.set("Čin samoaktuelizacije.",forKey: "41")

        //level
        preferences.set(0,forKey: "level")

        //poeni
        preferences.set(0,forKey: "poeni1")
        preferences.set(0,forKey: "poeni2")
        preferences.set(0,forKey: "poeni3")
        preferences.set(0,forKey: "poeni4")
        preferences.set(0,forKey: "poeni5")
        
       
    }
    
    func RemoveAllActivites() {
        
        let preferences = UserDefaults.standard
        
        
        for i in 1...50{
                do{
                
                preferences.removeObject(forKey: String(i))
                    
                }
                catch{
                    
                }
            }
            preferences.removeObject(forKey: "poeni1")
            preferences.removeObject(forKey: "poeni2")
            preferences.removeObject(forKey: "poeni3")
            preferences.removeObject(forKey: "poeni4")
            preferences.removeObject(forKey: "poeni5")
    }
    
    
}



/*var converted: Date
               var local:Date

               //Uzmi iz Shared Preferences i lokalni datum
               if((pref.getString("now",null) != null)
                   ) {
                   val sdf = SimpleDateFormat("yyyy-MM-dd")
                   try {

                       val now = pref.getString("now", null)
                       converted = sdf.parse(now)

                       val date = Date()
                       val currentDate:String = sdf.format(date)
                       local= sdf.parse(currentDate)

                       //ako je novi dan
                       if(converted<local) {
                           editor.putString("now",currentDate)
                           RemoveAllActivites(editor)
                           AddAllActivites(editor)
                           //DO SHIT , ReADD activites, Adjust level to 1,
                       }
                   }
                   catch(e:Exception) {e.printStackTrace()  }
 */

               
        // Do any additional setup after loading the view.
    
    
    

        



