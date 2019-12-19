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

class ViewController: UIViewController, SettingsDelegate {
    
    func updateSettings(updatedIntervals: [String], updatedMethods: [String]) {
 
        selectedMethods = updatedMethods
        selectedIntervals = updatedIntervals
        
        update()
    }
    
    @IBOutlet weak var selectedMethodsLabel: UILabel!
    @IBOutlet var toggleButtonCollection:[Toggle]!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var beginButton: Toggle!
    
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    var intervalData:IntervalData!
    var interval:Intervals!
    var root:String!
    var selectedIntervals:[String]!
    var selectedMethods:[String]!
    var settingsDelegate:SettingsDelegate?

    let MAX_ANSWER:Float = 10.0
    var CURR_ANSWER:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIntervals = IntervalsSelected.shared.intervals!
        selectedMethods = IntervalsSelected.shared.methods!

        //Set up initial intervals
        settingsDelegate?.updateSettings(updatedIntervals: selectedIntervals, updatedMethods: selectedMethods)
        update()
        
        intervalData = loadIntervalFile(filename:"Intervals")
        
        updateProgress()

    }
    
    //Updates the intervals and methods we are using, enabling and disabling buttons
    func update() {
        //Set Up
        for toggle in toggleButtonCollection {
            if selectedIntervals.contains(toggle.titleLabel!.text!) {
                toggle.isEnabled = true
            } else {
                toggle.isEnabled = false
            }
        }
        
        var methodsString = ""
        for i in selectedMethods {
            methodsString = methodsString+" "+i
        }
        selectedMethodsLabel.text = methodsString
    }
    
    func updateProgress() {
        progressView.setProgress(CURR_ANSWER, animated: true)
    }
    
    @IBAction func beginPressed(_ sender: Any) {
        start()
    }
    
    func start() {
        //Select ascending, decending, or harmonic depending on settings
        let methods = IntervalsSelected.shared.methods
        let method = methods?.randomElement()
        
        //Grab random interval from the method category
        var selectedMethod:[Intervals]

        if method == "Ascending" {
            selectedMethod = intervalData.interval_asc
        } else if method == "Decending" {
            selectedMethod = intervalData.interval_dec
        } else { //Harmonic
            selectedMethod = intervalData.interval_asc //we just need two intervals doesn't matter the order
        }

        interval = selectedMethod.randomElement()
        root = interval?.root //randomly pick a root from the list
        
        //Stick all the intervals in a dict and then select one of them at random
        let currentStructure:[String:String] = ["root":interval.root, "m2":interval.m2, "M2":interval.M2, "m3":interval.m3, "M3":interval.M3, "P4":interval.P4, "TT":interval.TT, "P5":interval.P5, "m6":interval.m6, "M6":interval.M6, "m7":interval.m7, "M7":interval.M7, "P8":interval.P8]
        
        //Pick an interval from the settings
        
        let randomIntervalSelection = currentStructure.randomElement()
        let intervalNoteFromRoot = (randomIntervalSelection?.value)!
        

        
        playIntervalSound(root: root!, interval: intervalNoteFromRoot)
    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
    }
    
    @IBAction func major3Pressed(_ sender: Any) {
    }
    
    @IBAction func perfect4Pressed(_ sender: Any) {
    }
    
    @IBAction func tritonePressed(_ sender: Any) {
    }
    
    @IBAction func perfect5Pressed(_ sender: Any) {
    }
    
    @IBAction func minor6Pressed(_ sender: Any) {
    }
    
    @IBAction func major6Pressed(_ sender: Any) {
    }
    
    @IBAction func minor7Pressed(_ sender: Any) {
    }
    
    @IBAction func major7Pressed(_ sender: Any) {
    }
    
    @IBAction func perfect8Pressed(_ sender: Any) {
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SettingsSegue" {
            if let vc = segue.destination as? SettingsViewController {
                vc.SettingsDelegate = self
                IntervalsSelected.shared.intervals = selectedIntervals
                IntervalsSelected.shared.methods = selectedMethods
            }
        }
    }
  
    
    
    
    
}


