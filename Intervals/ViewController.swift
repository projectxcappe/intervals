//
//  ViewController.swift
//  Intervals
//
//  Created by Cass Pangell on 12/14/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var rootNoteLabel: UILabel!
    @IBOutlet weak var intervalNoteLabel: UILabel!
    
    @IBOutlet weak var minor2Button: Toggle!
    @IBOutlet weak var major2Button: Toggle!
    @IBOutlet weak var minor3Button: Toggle!
    @IBOutlet weak var major3Button: Toggle!
    @IBOutlet weak var perfect4Button: Toggle!
    @IBOutlet weak var tritoneButton: Toggle!
    @IBOutlet weak var perfect5Button: Toggle!
    @IBOutlet weak var minor6Button: Toggle!
    @IBOutlet weak var major6Button: Toggle!
    @IBOutlet weak var minor7Button: Toggle!
    @IBOutlet weak var major7Button: Toggle!
    @IBOutlet weak var perfect8Button: Toggle!
    
    @IBOutlet weak var ascButton: Toggle!
    @IBOutlet weak var decButton: Toggle!
    @IBOutlet weak var harmButton: Toggle!

    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    var intervalData:[Intervals]!
    var interval:Intervals!
    var root:String!
    var selectedIntervals:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIntervals = []
        intervalData = loadIntervalFile(filename:"Intervals")
        interval = intervalData.randomElement()
        root = interval?.root //randomly pick a root from the list
        
        rootNoteLabel.text = root
        

    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
        minor2Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.m2) {
            selectedIntervals.remove(object: self.interval.m2)
        } else {
            selectedIntervals.append(self.interval.m2)
        }
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
        major2Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.M2) {
            selectedIntervals.remove(object: self.interval.M2)
        } else {
            selectedIntervals.append(self.interval.M2)
        }

    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
        minor3Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.m3) {
            selectedIntervals.remove(object: self.interval.m3)
        } else {
            selectedIntervals.append(self.interval.m3)
        }
        

    }
    
    @IBAction func major3Pressed(_ sender: Any) {
        major3Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.M3) {
            selectedIntervals.remove(object: self.interval.M3)
        } else {
            selectedIntervals.append(self.interval.M3)
        }
 

    }
    
    @IBAction func perfect4Pressed(_ sender: Any) {
        perfect4Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.P4) {
            selectedIntervals.remove(object: self.interval.P4)
        } else {
            selectedIntervals.append(self.interval.P4)
        }
      
        
    }
    
    @IBAction func tritonePressed(_ sender: Any) {
        tritoneButton.toggleTapped()
        
        if selectedIntervals.contains(self.interval.TT) {
            selectedIntervals.remove(object: self.interval.TT)
        } else {
            selectedIntervals.append(self.interval.TT)
        }
        
    
    }
    
    @IBAction func perfect5Pressed(_ sender: Any) {
        perfect5Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.P5) {
            selectedIntervals.remove(object: self.interval.P5)
        } else {
            selectedIntervals.append(self.interval.P5)
        }
        
   
    }
    
    @IBAction func minor6Pressed(_ sender: Any) {
        minor6Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.m6) {
            selectedIntervals.remove(object: self.interval.m6)
        } else {
            selectedIntervals.append(self.interval.m6)
        }
    
    }
    
    @IBAction func major6Pressed(_ sender: Any) {
        major6Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.M6) {
            selectedIntervals.remove(object: self.interval.M6)
        } else {
            selectedIntervals.append(self.interval.M6)
        }
       
    }
    
    @IBAction func minor7Pressed(_ sender: Any) {
        minor7Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.m7) {
            selectedIntervals.remove(object: self.interval.m7)
        } else {
            selectedIntervals.append(self.interval.m7)
        }
    
    }
    
    @IBAction func major7Pressed(_ sender: Any) {
        major7Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.M7) {
            selectedIntervals.remove(object: self.interval.M7)
        } else {
            selectedIntervals.append(self.interval.M7)
        }

    }
    
    @IBAction func perfect8Pressed(_ sender: Any) {
        perfect8Button.toggleTapped()
        
        if selectedIntervals.contains(self.interval.P8) {
            selectedIntervals.remove(object: self.interval.P8)
        } else {
            selectedIntervals.append(self.interval.P8)
        }
  
    }
    
    @IBAction func ascPressed(_ sender: Any) {
        ascButton.toggleTapped()
        
        if selectedIntervals.contains("Ascending") {
            selectedIntervals.remove(object: "Ascending")
        } else {
            selectedIntervals.append("Ascending")
        }
    }
    
    
    @IBAction func decPressed(_ sender: Any) {
        decButton.toggleTapped()
        
        if selectedIntervals.contains("Decending") {
            selectedIntervals.remove(object: "Decending")
        } else {
            selectedIntervals.append("Decending")
        }
    }
    
    @IBAction func harmPressed(_ sender: Any) {
        harmButton.toggleTapped()
        
        if selectedIntervals.contains("Harmonic") {
            selectedIntervals.remove(object: "Harmonic")
        } else {
            selectedIntervals.append("Harmonic")
        }
    }
    
    
}


