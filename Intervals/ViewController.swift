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
    var intervalData:[Intervals]!
    var root:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        intervalData = loadIntervalFile(filename:"Intervals")
        let interval = intervalData.randomElement()
        root = interval?.root

    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
        playIntervalSound(root: "A3")
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
    }
    
    @IBAction func major3Pressed(_ sender: Any) {
    }
    
    

}


