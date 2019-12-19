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
        
        IntervalsSelected.shared.intervals! = selectedIntervals
        IntervalsSelected.shared.methods! = selectedMethods
        
        update()
    }
    
    @IBOutlet weak var selectedMethodsLabel: UILabel!
    @IBOutlet var toggleButtonCollection:[Toggle]!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var beginButton: Toggle!
    @IBOutlet weak var correctLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    var intervalData:IntervalData!
    var interval:Intervals!
    var root:String!
    var selectedIntervals:[String]!
    var selectedMethods:[String]!
    var settingsDelegate:SettingsDelegate?
    
    var randomIntervalSelection:String!
    var replayCurrentInterval:Bool!

    let MAX_ANSWER:Float = 10.0
    var CURR_ANSWER:Float = 0.0
    
    var intervalNoteFromRoot:String!
    var method:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up
        selectedIntervals = IntervalsSelected.shared.intervals!
        selectedMethods = IntervalsSelected.shared.methods!
        replayCurrentInterval = false
        correctLabel.alpha = 0.0
        
        //Set up initial intervals
        settingsDelegate?.updateSettings(updatedIntervals: selectedIntervals, updatedMethods: selectedMethods)
        update()
        
        intervalData = loadIntervalFile(filename:"Intervals")
        
        updateProgress()

    }
    
    //Updates the intervals and methods we are using, enabling and disabling buttons
    func update() {
        
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

    func playInterval() {
        
        //If current interval needs to be played, play it, otherwise select a new interval
        if !replayCurrentInterval {
            //Select ascending, decending, or harmonic depending on settings
            let methods = IntervalsSelected.shared.methods
            method = methods?.randomElement()
            var intervalDataFromMethod:[Intervals]

            //Get all interval data from appropriate method (Asc, Dec, Harm etc)
            if method == "Ascending" {
                intervalDataFromMethod = intervalData.interval_asc
            } else if method == "Decending" {
                intervalDataFromMethod = intervalData.interval_dec
            } else { //Harmonic
                intervalDataFromMethod = intervalData.interval_asc //we just need two intervals doesn't matter the order
            }

            //Grab random interval data structure from the method category
            interval = intervalDataFromMethod.randomElement()
            root = interval?.root //randomly pick a root note from the list
            
            //Stick all the intervals in a dict
            let currentStructure:[String:String] = ["root":interval.root, "m2":interval.m2, "M2":interval.M2, "m3":interval.m3, "M3":interval.M3, "P4":interval.P4, "TT":interval.TT, "P5":interval.P5, "m6":interval.m6, "M6":interval.M6, "m7":interval.m7, "M7":interval.M7, "P8":interval.P8]

            //Grab intervals from settings and get the real note value
            randomIntervalSelection = IntervalsSelected.shared.intervals?.randomElement()
            intervalNoteFromRoot = currentStructure[randomIntervalSelection!]
            
            replayCurrentInterval = true //allow user to replay this interval if needed to
        }
        
        if method != "Harmonic" {
            playIntervalSound(root: root!, interval: intervalNoteFromRoot!)
        } else {
            playHarmonicIntervalSound(root: root!, interval: intervalNoteFromRoot!)
        }

    }
    
    @IBAction func beginPressed(_ sender: Any) {
        beginButton.setTitle("Replay Interval", for: .normal)
        playInterval()
    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
        checkAnswer(guess: "m2", answer: randomIntervalSelection)
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
        checkAnswer(guess: "M2", answer: randomIntervalSelection)
    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
        checkAnswer(guess: "m3", answer: randomIntervalSelection)
    }
    
    @IBAction func major3Pressed(_ sender: Any) {
        checkAnswer(guess: "M3", answer: randomIntervalSelection)
    }
    
    @IBAction func perfect4Pressed(_ sender: Any) {
        checkAnswer(guess: "P4", answer: randomIntervalSelection)
    }
    
    @IBAction func tritonePressed(_ sender: Any) {
        checkAnswer(guess: "TT", answer: randomIntervalSelection)
    }
    
    @IBAction func perfect5Pressed(_ sender: Any) {
        checkAnswer(guess: "P5", answer: randomIntervalSelection)
    }
    
    @IBAction func minor6Pressed(_ sender: Any) {
        checkAnswer(guess: "m6", answer: randomIntervalSelection)
    }
    
    @IBAction func major6Pressed(_ sender: Any) {
        checkAnswer(guess: "M6", answer: randomIntervalSelection)
    }
    
    @IBAction func minor7Pressed(_ sender: Any) {
        checkAnswer(guess: "m7", answer: randomIntervalSelection)
    }
    
    @IBAction func major7Pressed(_ sender: Any) {
        checkAnswer(guess: "M7", answer: randomIntervalSelection)
    }
    
    @IBAction func perfect8Pressed(_ sender: Any) {
        checkAnswer(guess: "P8", answer: randomIntervalSelection)
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


