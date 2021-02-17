//
//  SideController.swift
//  pon
//
//  Created by Demir Dazdarevic on 16.2.21..
//

import Foundation
import UIKit

class SideController: UIViewController{
    
    struct usr: Decodable {
        let email: String
        let fullname: String
        let number: String
        let address: String
        let img:String
        
        }
    
    @IBOutlet weak var name: UIButton!
    @IBOutlet weak var num: UIButton!
    @IBOutlet weak var adresa: UIButton!
    @IBOutlet weak var mail: UIButton!
    
    @IBOutlet weak var imag: UIButton!
    
    override func viewDidLoad() {
        
        
        var result = Data()
        var resultString = "null"
        let preferences = UserDefaults.standard
      
        
        let url = URL(string: "https://webapi20210118170049.azurewebsites.net/api/User/?email=\(preferences.string(forKey: "email") ?? "")")!
        //SEMAFOR DA CEKA DA SE GET URADI
        let sem = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            result = data
            resultString = String(data: data, encoding: .utf8) ?? "null"
            
          
            sem.signal()
        }

    task.resume()
    sem.wait()
    if (resultString != "null") {
        let json = try! JSONDecoder().decode(usr.self, from: result)
        
        name.setTitle("Full name: \(json.fullname)", for: .normal)
        num.setTitle("Phone num: \(json.number)", for: .normal)
        adresa.setTitle("Address: \(json.address)", for: .normal)
        mail.setTitle("Email: \(json.email)", for: .normal)
        imag.setBackgroundImage(UIImage(named: "\(json.img)"), for: .normal)
        
    }
    }
    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: "Obaveštenje:", message: "Sada ćete biti odjavljeni!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                do{
                    UserDefaults.resetStandardUserDefaults()
                    sleep(1)
                    exit(0)
                    
                    
                }
                        
                    

              case .cancel:
                do{
                    self.dismiss(animated: true, completion: nil)
                    
                }

              case .destructive:
                do{
                    self.dismiss(animated: true, completion: nil)
                    
                }


              @unknown default:
                print("error")
                
                            }
            }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
