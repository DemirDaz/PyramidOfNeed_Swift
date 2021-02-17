//
//  SettingsController.swift
//  pon
//
//  Created by Demir Dazdarevic on 15.2.21..
//

import Foundation
import UIKit

class SettingsController: UIViewController{
    
    struct User: Decodable {
        let email: String
        let password: String
        }
    
    override func viewDidLoad() {
        self.showSideMenu()
        print("demco")
    }
    
    
   
    
    @IBAction func editButton(_ sender: Any) {
        //get vraca json..treba da se defragmentuje..vidi Kotlin apk za taj deo.
       
    }
    
    @IBAction func removeButton(_ sender: Any) {
        let alert = UIAlertController(title: "Soon:", message: "Coming soon!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                do{
                    
                    
                    
                }
                        
                    

              case .cancel:
                do{
                    
                    
                }

              case .destructive:
                do{
                    
                    
                }


              @unknown default:
                print("error")
                
                            }
            }))
        
        self.present(alert, animated: true, completion: nil)
        

        
        //post .. podatke u payload
        
    }
    @IBAction func clearButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Obaveštenje:", message: "Svi sačuvani podaci će biti obrisani!", preferredStyle: .alert)
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
