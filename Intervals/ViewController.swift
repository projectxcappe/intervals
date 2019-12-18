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
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    var intervalData:[Intervals]!
    var interval:Intervals!
    var root:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        intervalData = loadIntervalFile(filename:"Intervals")
        interval = intervalData.randomElement()
        root = interval?.root //randomly pick a root from the list
        
        rootNoteLabel.text = root
        

    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
        let interval = self.interval.m2
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
        
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
        let interval = self.interval.M2
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
        

    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
        let interval = self.interval.m3
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)

    }
    
    @IBAction func major3Pressed(_ sender: Any) {
        let interval = self.interval.M3
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)

    }
    
    @IBAction func perfect4Pressed(_ sender: Any) {
        let interval = self.interval.P4
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
        
    }
    
    @IBAction func tritonePressed(_ sender: Any) {
        let interval = self.interval.TT
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
    }
    
    @IBAction func perfect5Pressed(_ sender: Any) {
        let interval = self.interval.P5
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
    }
    
    @IBAction func minor6Pressed(_ sender: Any) {
        let interval = self.interval.m6
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
    }
    
    @IBAction func major6Pressed(_ sender: Any) {
        let interval = self.interval.M6
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
    }
    
    @IBAction func minor7Pressed(_ sender: Any) {
        let interval = self.interval.m7
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
    }
    
    @IBAction func major7Pressed(_ sender: Any) {
        let interval = self.interval.M7
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
    }
    
    @IBAction func perfect8Pressed(_ sender: Any) {
        let interval = self.interval.P8
        
        intervalNoteLabel.text = interval
        playHarmonicIntervalSound(root: root, interval: interval)
    }
    
    
}


