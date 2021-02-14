//
//  druga.swift
//  pon
//
//  Created by Demir Dazdarevic on 14.2.21..
//


import Foundation
import UIKit
import Lottie

class druga: UIViewController{
    
  /* "checklist.json",
    "Potrebe niže u hijerarhiji moraju biti zadovoljene pre nego što pojedinac može da odgovori na potrebe viših nivoa."+"\n\n" + "Od dna hijerarhije nagore, potrebe su: " + "\n\n"  + "fiziološke potrebe" + "\n\n" + "potrebe bezbednosti"+"\n\n" + "potrebe za ljubavlju i pripadnošću"
   +"\n\n" + "potrebe poštovanja" + "\n\n" + "samoaktualizacija"))
    */
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet var parentView: UIView!
    private var animationView: AnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        animationView!.stop()
        animationView!.play()
        
    }
    
    override func viewDidLoad() {
        animationView = .init(name: "checklist")
        
        animationView!.frame = .init(x: view.bounds.midX - 150, y: 50, width: 300, height: 300)
    // 3. Set animation content mode
    
        animationView!.contentMode = .scaleAspectFit
        animationView?.layoutMargins.top = 30
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 0.5
        
        parentView.addSubview(animationView!)
        view.bringSubviewToFront(label)
        //prikaz animacijes
        // 2. Start AnimationView with animation name (without extension)
        animationView!.play()
        label.text = "Potrebe niže u hijerarhiji moraju biti zadovoljene \n pre nego što pojedinac može da odgovori na potrebe \n viših nivoa. \n\n Od dna hijerarhije nagore, potrebe su:  \n\n  fiziološke potrebe  \n\n potrebe bezbednosti \n\n potrebe za ljubavlju i pripadnošću \n\n potrebe poštovanja \n\n  samoaktualizacija"
        super.viewDidLoad()
   
        }
}
