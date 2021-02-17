//
//  boardingController.swift
//  pon
//
//  Created by Demir Dazdarevic on 13.2.21..
//

import Foundation
import UIKit


class boardingController: UIViewController{
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    var zauzetmejl = true
    var result = Data()
    var resultString = String()
    var sifra = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()}
           
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    func alertDobar() {
        //POP UP poruka
        let alert = UIAlertController(title: "Uspesna prijava!", message: "Možete pristupiti aplikaciji na dugme OK.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                do{
                        let preferences = UserDefaults.standard
                        preferences.set(1,forKey: "prviput")
                        let formatter = DateFormatter()
                        let currentDateTime = Date()
                        formatter.dateFormat = "yyyy/MM/dd"
                        //formatter.dateStyle = .short
                        let date:String = formatter.string(from: currentDateTime)

                        ///ako je prvi put pokrenuta app
                        ///Doesn't exist //dodaj now
                    preferences.setValue(self.user.text, forKey: "email")
                    preferences.setValue(self.pass.text, forKey: "password")
                        preferences.set(date,forKey: "now")
                    self.performSegue(withIdentifier: "ulaz", sender: nil)
                    
                }
              case .cancel:
                do{
                        let preferences = UserDefaults.standard
                        preferences.set(1,forKey: "prviput")
                        let formatter = DateFormatter()
                        let currentDateTime = Date()
                        formatter.dateFormat = "yyyy/MM/dd"
                        //formatter.dateStyle = .short
                        let date:String = formatter.string(from: currentDateTime)
                 
                    preferences.setValue(self.user.text, forKey: "email")
                    preferences.setValue(self.pass.text, forKey: "password")
                        ///ako je prvi put pokrenuta app
                        ///Doesn't exist //dodaj now
                        
                        preferences.set(date,forKey: "now")
                    self.performSegue(withIdentifier: "ulaz", sender: nil)
                    
                }

              case .destructive:
                    print("destructive")


              @unknown default:
                print("error")
                
                            }
            }))
        
        self.present(alert, animated: true, completion: nil)
        //ALERT DONE ||| //POP UP poruka
        
    }
    
    func alertDobrodosli() {
        //POP UP poruka
        let alert = UIAlertController(title: "Welcome!", message: "Dobrodošli!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { action in
              switch action.style{
              case .default:
                do{
                        let preferences = UserDefaults.standard
                        preferences.set(1,forKey: "prviput")
                        let formatter = DateFormatter()
                        let currentDateTime = Date()
                        formatter.dateFormat = "yyyy/MM/dd"
                        //formatter.dateStyle = .short
                        let date:String = formatter.string(from: currentDateTime)

                        ///ako je prvi put pokrenuta app
                        ///Doesn't exist //dodaj now
                    preferences.setValue(self.user.text, forKey: "email")
                    preferences.setValue(self.pass.text, forKey: "password")
                        preferences.set(date,forKey: "now")
                    self.performSegue(withIdentifier: "ulaz", sender: nil)
                    
                }
              case .cancel:
                do{
                        let preferences = UserDefaults.standard
                        preferences.set(1,forKey: "prviput")
                        let formatter = DateFormatter()
                        let currentDateTime = Date()
                        formatter.dateFormat = "yyyy/MM/dd"
                        //formatter.dateStyle = .short
                        let date:String = formatter.string(from: currentDateTime)
                 
                    preferences.setValue(self.user.text, forKey: "email")
                    preferences.setValue(self.pass.text, forKey: "password")
                        ///ako je prvi put pokrenuta app
                        ///Doesn't exist //dodaj now
                        
                        preferences.set(date,forKey: "now")
                    self.performSegue(withIdentifier: "ulaz", sender: nil)
                    
                }

              case .destructive:
                    print("destructive")


              @unknown default:
                print("error")
                
                            }
            }))
        
        self.present(alert, animated: true, completion: nil)
        //ALERT DONE ||| //POP UP poruka
        
    }
    
    func alertLos() {
        //POP UP poruka
        let alert = UIAlertController(title: "GREŠKA!", message: "Zauzeta je email adresa, ili ste pogrešili šifru .", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                do{
                    self.user.text = ""
                    self.pass.text = ""
                }
                        
                    

              case .cancel:
                do{
                    self.user.text = ""
                    self.pass.text = ""
                }

              case .destructive:
                do{
                    self.user.text = ""
                    self.pass.text = ""
                }


              @unknown default:
                print("error")
                
                            }
            }))
        
        self.present(alert, animated: true, completion: nil)
        //ALERT DONE |||
    }
    
    func alertReg() {
        //POP UP poruka
        let alert = UIAlertController(title: "Uspešna registracija!", message: "Možete pristupiti aplikaciji! Kliknite jos jednom na Login dugme za pristup.", preferredStyle: .alert)
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
        //ALERT DONE |||
    }
    
   
    struct User: Decodable {
        let email: String
        let password: String
        }
   
    
    @IBAction func login(_ sender: Any) {
        
                    
                    // GET to test if loging
                    //provera
                   
        
                    if(zauzetmejl) {
                        
                        // da li je email zauzet
                        let url = URL(string: "https://webapi20210118170049.azurewebsites.net/api/User/?email=\(user.text ?? "samko")")!
                        
                       
                        //SEMAFOR DA CEKA DA SE GET URADI
                        let sem = DispatchSemaphore(value: 0)
                        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                            guard let data = data else {
                                //self.resultString = "null"
                                return }
                            
                            self.result = data
                            self.resultString = String(data: data, encoding: .utf8)!
                            print(self.resultString)
                            if(self.resultString != "null") {
                            let json = try! JSONDecoder().decode(User.self, from: self.result)
                                self.sifra = json.password }
                            sem.signal()
                           
                        }

                        task.resume()
                        sem.wait()
                        if (self.resultString != "null") {
                        //onda postoji taj mejl, ili se loguje ili pokusava da se registruje sa zauzetim
                         
                           
                           
                           // print("tu sam") //ovo radi prvo
                            
                           // loginButton.text = sifra.toString()
                            if(self.pass.text == sifra) {
                                //USPESNA VERIFIKACIJA
                                self.user.isHidden = true
                                self.pass.isHidden = true
                                
                               alertDobar()
                                
                                let preferences = UserDefaults.standard
                                preferences.setValue(self.user.text, forKey: "email")
                                preferences.setValue(self.pass.text, forKey: "password")

                               
                                }
                            else {
                                alertLos()
                                //NEUSPESAN LOGIN, ZAUZETA EMAIL ADRESA
                                
                        }
                            
                            
                        }
                        //AKO JE slobodna email adresa
                        if (resultString == "null") {
                            self.zauzetmejl = false
                            //POP UP poruka
                           alertReg()
                            }
                           
                        
                            }
                        if(zauzetmejl){
                            //
                            self.user.text = ""
                            self.pass.text = ""
                            
                            
                        }
                        

                        
                      if(!zauzetmejl) {
                        
                        //post .. podatke u payload
                        let url = URL(string: "https://webapi20210118170049.azurewebsites.net/api/User")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        let payload = "email=\(self.user.text ?? "samir")&password=\(self.pass.text ?? "samir")".data(using: .utf8)!
                       
                        let task = URLSession.shared.uploadTask(with: request, from: payload) { data, response, error in
                         
                            print(String(data: data!, encoding: .utf8) as Any)
                            
                        }
                        task.resume()
                        
                       
                        self.user.isHidden = true
                        self.pass.isHidden = true
                        
                        alertDobrodosli()
                        
                      
                    
                    }
                                
                            
                }

                        
                       
                      
                    
    }
    


          /*



                       
                               // loginButton.text = sifra.toString()
                                if(passwordEditText.text.toString() == sifra.toString()) {
                                    usernameEditText.visibility = View.GONE
                                    passwordEditText.visibility = View.GONE
                                    loginButton.text = "Uspešna prijava!"+"\n" + "Možete pristupiti aplikaciji na dugme Enter."
                                    loginButton.isClickable = false
                                    editor.putString("email",usernameEditText.text.toString())
                                    editor.putString("password",passwordEditText.text.toString())
                                    editor.apply()
                                }else {
                               // loginButton.text = "prvo"
                                pd.setTitle("Greška")
                                pd.setMessage("Zauzeta email adresa!")
                                pd.show() }
                            }
                            
           //
           
           
            //let newViewController = ViewController()
            //parent?.present(newViewController, animated: true, completion: nil)
        //self.present(newViewController, animated: true, completion: nil)
            //onboardingContainer.removeFromSuperview()
    }
    
}
            */
 
