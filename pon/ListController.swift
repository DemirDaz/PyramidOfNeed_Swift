//
//  ListController.swift
//  pon
//
//  Created by Demir Dazdarevic on 4.2.21..
//

import Foundation
import UIKit


class ListController: UIViewController {
    
    
   
 
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var zadaci=[String]()
   
    var freshLaunch = true
    
    override func viewWillAppear(_ animated: Bool) {
         if freshLaunch == true {
             freshLaunch = false
            self.tabBarController!.selectedIndex = 1
            //self.tabBarController!.tabBar.shadowImage = nil
            
           
         }
    }
     
    override func viewDidLoad() {
        
        
       // self.tabBarController!.tabBar.shadowImage = nil
        super.viewDidLoad()
        let preferences = UserDefaults.standard
        if preferences.integer(forKey: "level") == 0 {
            ///Lazni kod
            
            for i in 1...10 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    print("nema ovog")
                    continue }
                zadaci.append(temp)
            }
                
           
        }
        else if preferences.integer(forKey: "level") == 1 {
            do{
            for i in 1...10 {
                zadaci.append(preferences.string(forKey: String(i))!)
            }
                
            }
            catch{
                print("Greska kod appenda zadataka.")
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
       
        /*var items:[String]=["prvi","drugi","treci"]
       
         
        for item in items{
            var novi = UITableViewCell()
            var label = UILabel()
            let dugme = Checkbox(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
           
           // novi.addSubview(dugme)
            //novi.alignmentRectInsets.left = 20
            
            
            
            label.backgroundColor = UIColor.yellow
            
            label.textAlignment = .center
            label.text = item
            novi.addSubview(label)
            novi.addSubview(dugme)
            //label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            //label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            tabl.addSubview(novi)
            
          
            //novi.centerYAnchor.constraint(equalTo: listaZadataka.centerYAnchor).isActive = true
            //novi.centerXAnchor.constraint(equalTo: listaZadataka.centerXAnchor).isActive = true
           
           // novi.addArrangedSubview(dugme)
            
            
            /*
            label.centerYAnchor.constraint(equalTo: novi.centerYAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: novi.centerXAnchor).isActive = true
            */
            
            //novi.addSubview(label)
            //novi.addSubview(dugme)
            
            */
            
  
        
        
        
      
      
        /*for item in items {
            var novi = Zadatak.init(frame: self.accessibilityFrame)
            novi.zad.text=item
            self.skrol.addSubview(novi) */
         /* item2.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0);n*/
          
        
        
        
        }
        
        
    }

extension ListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
}

extension ListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zadaci.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = zadaci[indexPath.row]
        let dugme = Checkbox(frame: CGRect(x: 300, y: 10, width: 25, height: 25))
        dugme.borderStyle = .circle
        dugme.uncheckedBorderColor = .white
        dugme.checkedBorderColor = .red
        dugme.checkmarkStyle = .tick
        dugme.checkmarkColor = .red
        cell.addSubview(dugme)
        return cell
    }
    
    
}





