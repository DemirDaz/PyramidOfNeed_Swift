//
//  Zadatak.swift
//  pon
//
//  Created by Demir Dazdarevic on 5.2.21..
//

import Foundation
import UIKit

class Zadatak : UIView {
    
    var shouldSetupConstraints = true
        
      var zad: UILabel!
      var bool: UISwitch!
      let screenSize = UIScreen.main.bounds
        
      override init(frame: CGRect){
        super.init(frame:frame)
        
        zad = UILabel.init(frame: CGRect.zero)
        zad.sizeToFit()
        self.addSubview(zad)
        
        bool = UISwitch.init(frame: CGRect.zero)
        bool.sizeToFit()
        self.addSubview(bool)
        
        
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
