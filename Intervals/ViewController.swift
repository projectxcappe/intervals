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
        root = interval?.root

    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
        
        playIntervalSound(note: root)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.playIntervalSound(note: self.interval.m2)
        }
        
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
    }
    
    @IBAction func major3Pressed(_ sender: Any) {
    }
    
    

}


