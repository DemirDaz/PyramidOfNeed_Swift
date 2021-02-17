//
//  EditorController.swift
//  pon
//
//  Created by Demir Dazdarevic on 17.2.21..
//

import Foundation
import UIKit

class EditorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return avatars.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        avatars[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedImg = avatars[row]
        print(row)
            // This method is triggered whenever the user makes a change to the picker selection.
            // The parameter named row and component represents what was selected.
        }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var num: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var img: UIPickerView!
    struct usr: Decodable {
        let email: String
        let fullname: String
        let number: String
        let address: String
        let img:String
        
        }
    
    let avatars:[String]=["boy-1.png","boy.png","girl-1.png","girl.png","man.png","man-1.png","man-2.png","man-3.png","man-4.png"]
    
    var selectedImg = ""
    
    override func viewDidLoad() {
        
        hideKeyboardWhenTappedAround()
        self.img.delegate = self
        self.img.dataSource = self
        
       
        
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
        
        
        name.text = json.fullname
        num.text = json.number
        address.text = json.address
        email.text = json.email
        selectedImg = json.img
        email.isUserInteractionEnabled = false
        
    }
        
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
    @IBAction func potvrdi(_ sender: Any) {
        let preferences = UserDefaults.standard
        let url2 = URL(string: "https://webapi20210118170049.azurewebsites.net/api/User")!
        var request2 = URLRequest(url: url2)
        request2.httpMethod = "POST"
        let payload2 = "email=\(preferences.string(forKey: "email") ?? "")&fullname=\(name.text ?? "")&address=\(address.text ?? "")&number=\(num.text ?? "")&img=\(selectedImg)".data(using: .utf8)!
        //let payload2 = "email=\(preferences.string(forKey:"email" ) ?? "")&password=\(preferences.string(forKey:"password" ) ?? "")&points=3".data(using: .utf8)!
        let task2 = URLSession.shared.uploadTask(with: request2, from: payload2) { data, response, error in
         
            print(String(data: data!, encoding: .utf8) as Any)
        }
        task2.resume()
        
        let alert = UIAlertController(title: "Obaveštenje:", message: "Uspešna izmena!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                do{
                    self.dismiss(animated: true, completion: nil)
                    
                }
                        
                    

              case .cancel:
                do{
                    self.dismiss(animated: true, completion: nil)
                    
                }

              case .destructive:
                do{
                    
                }


              @unknown default:
                print("error")
                
                            }
            }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
