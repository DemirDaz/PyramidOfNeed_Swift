//
//  ListController.swift
//  pon
//
//  Created by Demir Dazdarevic on 4.2.21..
//

import Foundation
import UIKit
import Lottie


class ListController: UIViewController {
    
    
   
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tekst: UILabel!
    @IBOutlet var parentView: UIView!
    
    
    private var animationView: AnimationView?
    var zadaci=[String]()
    var odabrani=[String]()
    var obrisani=[String]()//vazi od paljenja do paljenja apk, koliko nam i treba
    
    //DICTIONARY KEY:VALUE
    var svi:[String:String]=[
        "Sedam ili više sati sna.":"1",
        "Doručkovali.":"2",
        "Ručali":"3",
        "Večerali.":"4",
        "Popili dva ili više litra vode.":"5",
        "Bili u toalet.":"6",
        "Sit libido.":"7",
        "Radni odnos/školovanje.": "11",
        "Finansijska pokrivenost.": "12",
        "Zadovoljavajuće zdravstveno stanje.": "13",
        "Krov nad glavom, dom.": "14",
        "Kontaktirati prijatelja.": "21",
        "Kontakt sa porodicom.": "22",
        "Partnerski odnos.": "23",
        "Osetiti samouverenost.": "31",
        "Doživljaj poštovanja od okoline.": "32",
        "Čin samoaktuelizacije.": "41"
    ]
    
    
    
    
   
  
    
    override func viewWillAppear(_ animated: Bool) {
        
        zadaci.removeAll()
        changeTekst()
        addZadatke()
        ///ovako, UserDefaults cuva promene brisanja tek kad se aplikacija refreshuje..da bi se olaksalo, prvo proba da li moze da izbrise
        ///
        guard tableView != nil else {
            //animationView?.removeFromSuperview()
           
            
            // 6. Play animation
            
            
            return print("Before View: nema tebele")
        }
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
    }
     
    override func viewDidLoad() {
        
        
       // self.tabBarController!.tabBar.shadowImage = nil
        super.viewDidLoad()
        self.showSideMenu()
        
        
   
        }
    
    func changeTekst(){
        let preferences = UserDefaults.standard
        if(preferences.integer(forKey: "level")==0){
            tekst.text="Start your daily tasks  \n by clicking on plus button."
            
        }
        else if(preferences.integer(forKey: "level")==1){
            tekst.text="Current level of needs: \n physiology"
            
        }
        else if(preferences.integer(forKey: "level")==2){
            tekst.text="Current level of needs: \n security"
        }
        else if(preferences.integer(forKey: "level")==3){
            tekst.text="Current level of needs: \n belonging"
        }
        else if(preferences.integer(forKey: "level")==4){
            tekst.text="Current level of needs: \n esteem"
        }
        else if(preferences.integer(forKey: "level")==5){
            tekst.text="Current level of needs: \n self-actualization"
        }
        else if(preferences.integer(forKey: "level")==6){
            tekst.text="You had a day of fully met needs.\n Keep up the good work. \n You're awesome! \n Congrats! "
        }
        
        
    }
    
    func addUradjene() {
        let preferences = UserDefaults.standard
        var novipoeni = odabrani.count
        //makni odabrane
        for i in odabrani{
            preferences.removeObject(forKey: i)
            //zadaci.removeAll(where: T##(String) throws -> Bool)
            let intVal = Int(i) ?? 0
            if(intVal < 10){
                var poeni = preferences.integer(forKey: "poeni1")
                poeni += 1
                //novipoeni += 1
                preferences.setValue(poeni, forKey: "poeni1")
            }
            else if(intVal >= 10 && intVal<20){
                var poeni = preferences.integer(forKey: "poeni2")
                poeni += 1
                //novipoeni += 1
                preferences.setValue(poeni, forKey: "poeni2")
            }
            else if(intVal >= 20 && intVal<30){
                var poeni = preferences.integer(forKey: "poeni3")
                poeni += 1
                //novipoeni += 1
                preferences.setValue(poeni, forKey: "poeni3")
            }
            else if(intVal >= 30 && intVal<40){
                var poeni = preferences.integer(forKey: "poeni4")
                poeni += 1
                //novipoeni += 1
                preferences.setValue(poeni, forKey: "poeni4")
            }
            else if(intVal >= 40 && intVal<50){
                var poeni = preferences.integer(forKey: "poeni5")
                poeni += 1
                //novipoeni += 1
                preferences.setValue(poeni, forKey: "poeni5")
            }
        }
        
        setLevel(poeni1: preferences.integer(forKey: "poeni1"), poeni2: preferences.integer(forKey: "poeni2"), poeni3: preferences.integer(forKey: "poeni3"), poeni4: preferences.integer(forKey: "poeni4"), poeni5: preferences.integer(forKey: "poeni5"))
        
        
        //post .. podatke u payload
        //POST BODOVE
        let url = URL(string: "https://webapi20210118170049.azurewebsites.net/api/calendar")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload = "user=\(preferences.string(forKey:"email" ) ?? "")&date=\(preferences.string(forKey: "now") ?? "")&C1=\(preferences.integer(forKey: "poeni1"))&C2=\(preferences.integer(forKey: "poeni2"))&C3=\(preferences.integer(forKey: "poeni3"))&C4=\(preferences.integer(forKey: "poeni4"))&C5=\(preferences.integer(forKey: "poeni5"))".data(using: .utf8)!
        let task = URLSession.shared.uploadTask(with: request, from: payload) { data, response, error in
         
            print(String(data: data!, encoding: .utf8) as Any)
        }
        task.resume()
 
        let url2 = URL(string: "https://webapi20210118170049.azurewebsites.net/api/user")!
        var request2 = URLRequest(url: url2)
        request2.httpMethod = "POST"
        //let payload2 = "email=sveska@live.com&password=sifra&points=3".data(using: .utf8)!
        let payload2 = "email=\(preferences.string(forKey:"email" ) ?? "")&password=\(preferences.string(forKey:"password" ) ?? "")&points=\(novipoeni)".data(using: .utf8)!
        let task2 = URLSession.shared.uploadTask(with: request2, from: payload2) { data, response, error in
         
            print(String(data: data!, encoding: .utf8) as Any)
        }
        task2.resume()
        print(novipoeni)
        print(preferences.string(forKey:"email" ) ?? "")
        print(preferences.string(forKey:"password" ) ?? "")
        
        /*let url2 = URL(string: "https://webapi20210118170049.azurewebsites.net/api/user")!
        var request2 = URLRequest(url: url2)
        request2.httpMethod = "POST"
        let payload2 = "email=\(preferences.string(forKey:"email") ?? "")&points=5".data(using: .utf8)!
        let task2 = URLSession.shared.uploadTask(with: request2, from: payload2) { data, response, error in
            
            
            print(String(data: data!, encoding: .utf8) as Any)
        }
        task2.resume() */
        
        odabrani.removeAll() //cini mi se da treba da ocistim za kraj
    }
    
    func setLevel(poeni1:Int,poeni2:Int,poeni3:Int,poeni4:Int,poeni5:Int){
        print("Poeni- p1: \(poeni1) ,p2: \(poeni2) ,p3: \(poeni3) ,p4: \(poeni4) ,p5: \(poeni5) ")
        let preferences = UserDefaults.standard
            let ukupno = poeni1+poeni2+poeni3+poeni4+poeni5
            if(ukupno == 17 ) {
                preferences.setValue(6, forKey: "level")
            }
            else if(poeni1>=3 && poeni2>=2 && poeni3>=2 && poeni4>=1) {
                preferences.setValue(5, forKey: "level")
            }
            else if(poeni1>=3 && poeni2>=2 && poeni3>=2) {
                preferences.setValue(4, forKey: "level")
            }
            else if(poeni1>=3 && poeni2>=2 ) {
                preferences.setValue(3, forKey: "level")
            }
            else if(poeni1>=3 ) {
                preferences.setValue(2, forKey: "level")
            }
            else if(poeni1<3 ) {
                preferences.setValue(1, forKey: "level")
            }
            else {
                print("Greska kod setLevel")
                return
                
            }
            
        }
        //post NA SERVER
        
        //dodaj poene
        
        
        //ovde ide iz array na server , i brisi iz preferences
        //na plus nek se pozove ova f-ja
   
    
    func addZadatke() {
        
        let preferences = UserDefaults.standard
        if preferences.integer(forKey: "level") == 0 {
            ///Lazni kod
            
            //preferences.setValue(1, forKey: "level")
                //zadaciid.append(keyN)
            }
        
        else if preferences.integer(forKey: "level") == 1 {
            //print("na kec sam")
            for i in 1...10 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
                //print(zadaci.last)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 2 {
            for i in 1...20 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                   // print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 3 {
            for i in 1...30 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 4 {
            for i in 1...40 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 5 {
            for i in 1...45 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 6 {
        
            //Label i svaka cast za kraj dana
            
            guard  tableView != nil else {
                animationView?.removeFromSuperview()
                animationView = .init(name: "success")
                
                animationView!.frame = view.bounds
                
                // 3. Set animation content mode
                
                animationView!.contentMode = .scaleAspectFit
                
                // 4. Set animation loop mode
                
                animationView!.loopMode = .loop
                
                // 5. Adjust animation speed
                
                animationView!.animationSpeed = 0.5
                
                parentView.addSubview(animationView!)
                animationView!.play()
               
                print("Vec smo ga makli!")
                return
            }
            tableView.removeFromSuperview()
            animationView = .init(name: "success")
            
            animationView!.frame = view.bounds
            
            // 3. Set animation content mode
            
            animationView!.contentMode = .scaleAspectFit
            
            // 4. Set animation loop mode
            
            animationView!.loopMode = .loop
            
            // 5. Adjust animation speed
            
            animationView!.animationSpeed = 0.5
            
            parentView.addSubview(animationView!)
            
            //prikaz animacijes
            // 2. Start AnimationView with animation name (without extension)
            animationView!.play()
              
        
        }
            
                
            
            }
    
    @IBAction func updateBtn(_ sender: Any) {
        let preferences = UserDefaults.standard
        if preferences.integer(forKey: "level") == 0
        {
            preferences.setValue(1, forKey: "level")
        }
        addUradjene()
        
        //zadaci.removeAll()
        
        self.tabBarController!.selectedIndex = 2
        
        
    }
        
    }

extension ListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
}

extension ListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("broj Zadataka: \(zadaci.count)")
        return zadaci.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.init(named: "labelVerse")!
        
        cell.textLabel?.text = zadaci[indexPath.row]
        cell.layoutMargins.left = 40
        let siroka = self.view.window?.screen.bounds.width;
        
        let poz = siroka! - 70
        let dugme = Checkbox(frame: CGRect(x: poz, y: 20, width: 25, height: 25))
        
        
        dugme.borderStyle = .circle
        dugme.uncheckedBorderColor = .gray
        dugme.checkedBorderColor = .red
        dugme.checkmarkStyle = .tick
        dugme.checkmarkColor = .red
        dugme.isChecked = false
        
        //dugme.
        dugme.valueChanged = { [self] (isChecked) in
            if isChecked == true {odabrani.append("\(svi[self.zadaci[indexPath.row]] ?? "nesto")")
            //print("I am checked \(isChecked). Also, my name is \(self.zadaci[indexPath.row])")
                //print(odabrani.joined(separator: ","));
                
            }
            else {//odabrani.remove(at: Int(svi[self.zadaci[indexPath.row]])) Else Radi
                //odabrani sadrzi id-ove
                odabrani.removeAll{ $0 == "\(svi[self.zadaci[indexPath.row]] ?? "nesto")"};
               // print("I am : \(isChecked). Also, my name is \(svi[self.zadaci[indexPath.row]] ??  "neko")")
              //  print(odabrani.joined(separator: ","));
            }
       
            ///THIS IS WORKING SO GO FROM HERE UP ! bravo
        }
            
            
        dugme.checkboxFillColor = UIColor.init(named: "whibla")! //trebalo bi da nece da brejk
        cell.addSubview(dugme)
        return cell
    }
    
    
}
 /*
{ if(isChecked) {
    
    guard let temp = svi[zadaci[indexPath.row]]) else {
        return }
    odabrani.append(temp)
}
else {
    
}
*/



