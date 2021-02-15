//
//  FriendsController.swift
//  pon
//
//  Created by Demir Dazdarevic on 14.2.21..
//

import Foundation
import UIKit
import Lottie


class FriendsController: UIViewController {
var freshLaunch = true

    @IBOutlet weak var tableView: UITableView!
    var friends:[String]=["Demir Dazdarevic","Bakir Dazdarevic"]
    
    override func viewWillAppear(_ animated: Bool) {
    
   
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
    
    tableView.delegate = self
    tableView.dataSource = self
   // self.tabBarController!.tabBar.shadowImage = nil
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    self.hideKeyboardWhenTappedAround()
    self.showSideMenu()
    
    

    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension FriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
}

extension FriendsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.init(named: "labelVerse")!
        
        cell.textLabel?.text = friends[indexPath.row]
        cell.textLabel?.textAlignment = .center
        //cell.layoutMargins.left = 50
        let siroka = self.view.window?.screen.bounds.width;
        
        let poz = siroka! - 60
        let image = UIImageView(frame: CGRect(x: 20, y: 5, width: 40, height: 40))
        let boldConfig = UIImage.SymbolConfiguration(weight: .light)
        image.image =  UIImage(systemName: "circlebadge", withConfiguration: boldConfig)
        image.tintColor = UIColor.init(named: "labelVerse")!
       
        //let dugme = Checkbox(frame: CGRect(x: poz, y: 20, width: 25, height: 25))
        cell.addSubview(image)
        cell.bringSubviewToFront(image)
        let medal = UIButton(frame: CGRect(x: poz, y: 10, width: 32, height: 40))
        medal.setBackgroundImage(UIImage(systemName: "rosette", withConfiguration: boldConfig), for: UIControl.State.normal)
        medal.setTitle("5", for: UIControl.State.normal)
        medal.titleEdgeInsets.top = -10
        medal.setTitleColor(UIColor.init(named: "labelVerse")!, for: UIControl.State.normal)
        cell.addSubview(medal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("broj Zadataka: \(zadaci.count)")
        return friends.count
    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func showSideMenu() {
        

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.showSide))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func showSide() {
        self.performSegue(withIdentifier: "sidemen", sender: nil)
        
    }
}
    
    /*func FriendsController(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.init(named: "labelVerse")!
        
        cell.textLabel?.text = friends[indexPath.row]
        cell.layoutMargins.left = 50
        let siroka = self.view.window?.screen.bounds.width;
        
        let poz = siroka! - 70
        let image = UIImageView(frame: CGRect(x: 20, y: 20, width: 30, height: 30))
        image.image = UIImage.init(named: "circlebadge")
        //let dugme = Checkbox(frame: CGRect(x: poz, y: 20, width: 25, height: 25))
        cell.addSubview(image)
        cell.bringSubviewToFront(image)
        let medal = UIImageView(frame: CGRect(x: poz, y: 20, width: 30, height: 30))
        medal.image = UIImage.init(named: "rosette")
        cell.addSubview(medal)
        return cell
    }
    
    
}

        /*dugme.borderStyle = .circle
        dugme.uncheckedBorderColor = .gray
        dugme.checkedBorderColor = .red
        dugme.checkmarkStyle = .tick
        dugme.checkmarkColor = .red
        dugme.isChecked = false
        */
        //dugme.
        /*
        dugme.valueChanged = { [self] (isChecked) in
            if isChecked == true {odabrani.append("\(svi[self.zadaci[indexPath.row]] ?? "nesto")")
            //print("I am checked \(isChecked). Also, my name is \(self.zadaci[indexPath.row])")
                print(odabrani.joined(separator: ","));}
            else {//odabrani.remove(at: Int(svi[self.zadaci[indexPath.row]])) Else Radi
                //odabrani sadrzi id-ove
                odabrani.removeAll{ $0 == "\(svi[self.zadaci[indexPath.row]] ?? "nesto")"};
               // print("I am : \(isChecked). Also, my name is \(svi[self.zadaci[indexPath.row]] ??  "neko")")
                print(odabrani.joined(separator: ","));
            }
 */
       
            ///THIS IS WORKING SO GO FROM HERE UP ! bravo
        
            
            
        //dugme.checkboxFillColor = UIColor.init(named: "whibla")! //trebalo bi da nece da brejk
        //cell.addSubview(dugme)
 
*/
