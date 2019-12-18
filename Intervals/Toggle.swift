//
//  Toggle.swift
//  Intervals
//
//  Created by Cass Pangell on 12/17/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

import UIKit

@IBDesignable

class Toggle: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    func toggleTapped() {
        if self.isSelected == true {
            self.isSelected = false
//            self.backgroundColor = UIColor.white
        } else {
            self.isSelected = true
//            self.backgroundColor = UIColor.init(red: 50.0, green: 0.0, blue: 50.0, alpha: 20.0)
        }
    }

}
