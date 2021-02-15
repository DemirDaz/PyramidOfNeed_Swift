//
//  SettingsController.swift
//  pon
//
//  Created by Demir Dazdarevic on 15.2.21..
//

import Foundation
import UIKit

class SettingsController: UIViewController{
    
    override func viewDidLoad() {
        self.showSideMenu()
        print("demco")
    }
    
    @IBAction func editButton(_ sender: Any) {
        //get vraca json..treba da se defragmentuje..vidi Kotlin apk za taj deo.
        let url = URL(string: "https://webapi20210118170049.azurewebsites.net/api/user")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            
        }

        task.resume()
    }
    
    @IBAction func removeButton(_ sender: Any) {
        //post .. podatke u payload
        let url = URL(string: "https://webapi20210118170049.azurewebsites.net/api/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload = "email=demco@live.com&password=Demco123".data(using: .utf8)!
        let task = URLSession.shared.uploadTask(with: request, from: payload) { data, response, error in
            print(String(data: data!, encoding: .utf8))
        }
        task.resume()
    }
    @IBAction func clearButton(_ sender: Any) {
    }
    @IBAction func deleteProfile(_ sender: Any) {
    }
    @IBAction func signOut(_ sender: Any) {
    }
}
