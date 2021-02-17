//
//  prva.swift
//  pon
//
//  Created by Demir Dazdarevic on 14.2.21..
//

import Foundation
import UIKit
import Lottie

class prva: UIViewController{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet var ParentView: UIView!
    private var animationView: AnimationView?
    //"pyramid.json",
    // „Ono što je neophodno za promenu čoveka je promena svesti o samom sebi. “ - Abraham Maslov " + "\n\n" +"Maslovljeva hijerarhija potreba je motivaciona teorija u psihologiji koja se sastoji od petostepenog modela ljudskih potreba."
    override func viewWillAppear(_ animated: Bool) {
        animationView?.reloadImages()
        animationView!.play()
        
    }
    override func viewDidLoad() {
        animationView = .init(name: "pyramid")
        
            animationView!.frame = .init(x: view.bounds.midX - 150, y: 50, width: 300, height: 300)
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        animationView?.layoutMargins.top = 30
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .autoReverse
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 0.5
        
        ParentView.addSubview(animationView!)
        view.bringSubviewToFront(label)
        //prikaz animacijes
        // 2. Start AnimationView with animation name (without extension)
        animationView!.play()
                label.text = "„Ono što je neophodno za promenu čoveka \n je promena svesti o samom sebi. “ - Abraham Maslov\n \n\n Maslovljeva hijerarhija potreba je motivaciona \n teorija u psihologiji koja se sastoji od \n petostepenog modela ljudskih potreba."
        super.viewDidLoad()
        

   
        }
}
