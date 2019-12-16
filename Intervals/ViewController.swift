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
    
    var audioPlayer: AVAudioPlayer?
    var intervalData:[Intervals]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        intervalData = loadIntervalFile(filename:"Intervals")
        print(intervalData)
        
        //Play sound
        let pathToSound = Bundle.main.path(forResource: "A3", ofType: "aifc")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {}
        
    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
    }
    
    @IBAction func major3Pressed(_ sender: Any) {
    }
    
    

}
