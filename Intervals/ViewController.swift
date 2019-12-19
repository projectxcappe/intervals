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
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    var intervalData:[Intervals]!
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
        interval = intervalData.randomElement()
        root = interval?.root //randomly pick a root from the list
        print(root!)
        
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


