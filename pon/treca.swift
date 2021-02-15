//
//  treca.swift
//  pon
//
//  Created by Demir Dazdarevic on 14.2.21..
//

import Foundation
import UIKit
import Lottie

class treca: UIViewController{
    
    
    //"growthhelp.json",
    //"happy.json"
   /* "Svaka osoba je sposobna i ima želju da napreduje na hijararhiji ka nivou samoaktualizacije. Nažalost, napredak je često ometen neuspehom u zadovoljavanju potreba nižeg nivoa." + "\n\n" + "Ova aplikacija će vam pomoći da pratite kojih dana su vaše potrebe zadovoljene, ali i koji nivoi su bili problematični (oni čije potrebe nisu zadovoljene). Praćenjem saznajemo šta nam konkretno nedostaje. + "\n\n" + " „Formulacija problema je često bitnija od njegovog rešenja, što može biti samo stvar matematičke ili eksperimentalne veštine“ - Albert Ajnštajn" "))
     
   ,

                       
     */
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet var parentView: UIView!
    private var animationView: AnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        animationView!.play()
        
    }
    
    override func viewDidLoad() {
        animationView = .init(name: "happy")
        
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
        label.text = "Svaka osoba je sposobna i ima želju da napreduje na \n hijararhiji ka nivou samoaktualizacije. Nažalost,\n napredak je  često ometen neuspehom \n u zadovoljavanju  potreba nižeg nivoa. \n\n  Ova aplikacija će vam pomoći da pratite kojih \n dana su vaše  potrebe zadovoljene, \n ali i koji nivoi su  bili problematični  \n(oni čije potrebe nisu zadovoljene).\n Praćenjem saznajemo šta nam  konkretno nedostaje.  \n\n   „Formulacija problema je često bitnija od njegovog \n rešenja, što može biti samo stvar matematičke \n ili eksperimentalne veštine“ - Albert Ajnštajn"
        super.viewDidLoad()
   
        }
}
