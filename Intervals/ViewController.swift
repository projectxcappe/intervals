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

//For progress bar
enum Answer {
    case Correct
    case Incorrect
    case Setup
}

enum PlayType {
    case Interval
    case Chord
}

enum ChordQuality {
    case Major
    case Minor
}

let CHORDTIME = 4.0
let INTTIME = 2.0

class ViewController: UIViewController, SettingsDelegate {
    
    func updateSettings(updatedIntervals: [String], updatedMethods: [String], updatedChords: [String]) {
 
        selectedMethods = updatedMethods
        selectedIntervals = updatedIntervals
        selectedChords = updatedChords
        
        IntervalsSelected.shared.intervals! = selectedIntervals
        IntervalsSelected.shared.methods! = selectedMethods
        IntervalsSelected.shared.chords! = selectedChords
        
        updateSettings()
    }
    
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorSwitch: UISwitch!
    
    @IBOutlet weak var selectedMethodsLabel: UILabel!
    @IBOutlet var toggleButtonCollection:[Toggle]!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var beginButton: Toggle!
    @IBOutlet weak var correctLabel: UILabel!
    
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
    
    @IBOutlet weak var triadRootMajorButton: Toggle!
    @IBOutlet weak var triadRootMinorButton: Toggle!
    @IBOutlet weak var triad1stMajorButton: Toggle!
    @IBOutlet weak var triad1stMinorButton: Toggle!
    @IBOutlet weak var triad2ndMajorButton: Toggle!
    @IBOutlet weak var triad2ndMinorButton: Toggle!
    @IBOutlet weak var triadSwitch: UISwitch!
    
    @IBOutlet weak var dim7thButton: Toggle!
    @IBOutlet weak var fulldim7thButton: Toggle!
    @IBOutlet weak var dom7thButton: Toggle!
    @IBOutlet weak var minor7thButton: Toggle!
    @IBOutlet weak var major7thButton: Toggle!
    
    @IBOutlet var chordsButtonCollection: [Toggle]!
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    var intervalData:IntervalData!
    var interval:Intervals!
    var intervalSongs:Song!
    var intervalChords:Chord!
    
    var root:String!
    var selectedIntervals:[String]!
    var selectedMethods:[String]!
    var selectedChords:[String]!
    var allSelections:[String:String]!
    var selection:[String:String]!
    var settingsDelegate:SettingsDelegate?
    
    var randomIntervalSelection:String!
    var replayCurrentInterval:Bool!

    let MAX_ANSWER:Float = 1.0
    var CURR_ANSWER:Float = 0.0
    
    var intervalNoteFromRoot:String!
    var method:String!
    
    var chordNotesToBePlayed:[String]!
    var chordType:String!
    var chordQuality:ChordQuality!
    
    var isFirstRun:Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorSwitch.backgroundColor = UIColor.clear
        colorSwitch.onTintColor = UIColor.darkGray
        triadSwitch.backgroundColor = UIColor.clear
        triadSwitch.onTintColor = UIColor.darkGray
        
        //Set Up
        selection = [:]
        selectedIntervals = IntervalsSelected.shared.intervals!
        selectedMethods = IntervalsSelected.shared.methods!
        selectedChords = IntervalsSelected.shared.chords!
        
        replayCurrentInterval = false
        correctLabel.alpha = 0.0
        
        //Set up initial intervals
        settingsDelegate?.updateSettings(updatedIntervals: selectedIntervals, updatedMethods: selectedMethods, updatedChords: selectedChords)
        updateSettings()
        
        intervalData = loadIntervalFile(filename:"Intervals")
        intervalSongs = intervalData.Song
        intervalChords = intervalData.Chord
        
        isFirstRun = true
        
//        updateProgress(status: .Setup)

    }
    
    //Updates the intervals and methods we are using, enabling and disabling buttons
    func  updateSettings() {
        
        //Temp disable play button, honestly just for effect, shows we did something
        beginButton.isEnabled = false
        
        //Don't show ascending/decending label if no triads selected
        if selectedIntervals.count == 0 {
            selectedMethodsLabel.alpha = 0
        } else {
            selectedMethodsLabel.alpha = 100
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.beginButton.isEnabled = true
        }
        
        for toggle in toggleButtonCollection {
            if selectedIntervals.contains(toggle.titleLabel!.text!) {
                toggle.isEnabled = true
            } else {
                toggle.isEnabled = false
            }
        }
        
        for toggle in chordsButtonCollection {
            if selectedChords.contains(toggle.titleLabel!.text!) {
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
        
        //Stick all selections in a dictionary
        allSelections = [:] //clear it first
        for chord in selectedChords {
            allSelections.updateValue("chord", forKey: chord)
        }
        for interval in selectedIntervals {
            allSelections.updateValue("interval", forKey: interval)
        }
    }
    

    func playChord() {
        //If current chord needs to be played, play it, otherwise select a new interval
        if !replayCurrentInterval {
            
            //Select chord depending on settings, grab a random one from settings
            let chords = IntervalsSelected.shared.chords
            chordType = chords?.randomElement()
       
//            let qualityStructure:[String:[Triads]] = ["Major":[intervalChords!.Major], "Minor":[intervalChords!.Minor]]
            
            //Stick all the chords notes in an dict
            let currentStructure:[String:[[String]]] = [
                "Triad Root Major":intervalChords.Major.Triad_Root,
                "Triad Root Minor":intervalChords.Minor.Triad_Root,
                "Triad 1st Major":intervalChords.Major.Triad_1st,
                "Triad 1st Minor":intervalChords.Minor.Triad_1st,
                "Triad 2nd Major":intervalChords.Major.Triad_2nd,
                "Triad 2nd Minor":intervalChords.Minor.Triad_2nd,
                "M7":intervalChords.Seventh.Major,
                "m7":intervalChords.Seventh.Minor,
                "dom7":intervalChords.Seventh.Dominant,
                "fulldim7":intervalChords.Seventh.Full_Diminished,
                "halfdim7":intervalChords.Seventh.Half_Diminished]

            //Grab intervals from chord type and get the note values
            chordNotesToBePlayed = (currentStructure[chordType]?.randomElement())!
            print("chordNotesToBePlayed ", chordNotesToBePlayed)
            replayCurrentInterval = true //allow user to replay this interval if needed to
            
        }

        playChordSounds(chordNotes: chordNotesToBePlayed, chordQaulity:chordType)

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
                intervalDataFromMethod = intervalData.Ascending
            } else if method == "Decending" {
                intervalDataFromMethod = intervalData.Decending
            } else { //Harmonic
                intervalDataFromMethod = intervalData.Ascending //we just need two intervals doesn't matter the order
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
            playIntervalSound(root: root!, secondNote: intervalNoteFromRoot!, interval:randomIntervalSelection)
        } else {
            playHarmonicIntervalSound(root: root!, secondNote: intervalNoteFromRoot!, interval:randomIntervalSelection)
        }

    }

    @IBAction func beginPressed(_ sender: Any) {
        beginButton.setTitle("Replay Interval", for: .normal)
        
        //If first run get random selection and play it
        //else replay current selection
        if isFirstRun {
            getSelection()
            isFirstRun = false
        } else {
            play()
        }
    }
    
    func play() {
        
        for s in selection {
            if s.value == "chord" {
                playChord()
                toggleButtons(time:CHORDTIME)
            } else {
                playInterval()
                toggleButtons(time:INTTIME)
            }
        }
    }
    
    func getSelection() {
        //reset selection dictionary
        selection = [:]
        
        //Randomize selection and play appropriate method
        let randSelection = allSelections.randomElement()
        let value = randSelection?.value
        let key = randSelection?.key
        
        selection.updateValue(value!, forKey: key!)
        play()
        print("getSelection ", selection!)
    }
    
    @IBAction func minor2Pressed(_ sender: Any) {
        checkAnswer(guess: "m2", answer: randomIntervalSelection, method: method, buttonPressed:minor2Button)
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
        checkAnswer(guess: "M2", answer: randomIntervalSelection, method: method, buttonPressed: major2Button)
    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
        checkAnswer(guess: "m3", answer: randomIntervalSelection, method: method, buttonPressed: minor3Button)
    }
    
    @IBAction func major3Pressed(_ sender: Any) {
        checkAnswer(guess: "M3", answer: randomIntervalSelection, method: method, buttonPressed: major3Button)
    }
    
    @IBAction func perfect4Pressed(_ sender: Any) {
        checkAnswer(guess: "P4", answer: randomIntervalSelection, method: method, buttonPressed: perfect4Button)
    }
    
    @IBAction func tritonePressed(_ sender: Any) {
        checkAnswer(guess: "TT", answer: randomIntervalSelection, method: method, buttonPressed: tritoneButton)
    }
    
    @IBAction func perfect5Pressed(_ sender: Any) {
        checkAnswer(guess: "P5", answer: randomIntervalSelection, method: method, buttonPressed: perfect5Button)
    }
    
    @IBAction func minor6Pressed(_ sender: Any) {
        checkAnswer(guess: "m6", answer: randomIntervalSelection, method: method, buttonPressed: minor6Button)
    }
    
    @IBAction func major6Pressed(_ sender: Any) {
        checkAnswer(guess: "M6", answer: randomIntervalSelection, method: method, buttonPressed: major6Button)
    }
    
    @IBAction func minor7Pressed(_ sender: Any) {
        checkAnswer(guess: "m7", answer: randomIntervalSelection, method: method, buttonPressed: minor7Button)
    }
    
    @IBAction func major7Pressed(_ sender: Any) {
        checkAnswer(guess: "M7", answer: randomIntervalSelection, method: method, buttonPressed: major7Button)
    }
    
    @IBAction func perfect8Pressed(_ sender: Any) {
        checkAnswer(guess: "P8", answer: randomIntervalSelection, method: method, buttonPressed: perfect8Button)
    }
    
    @IBAction func triadRootMajorPressed(_ sender: Any) {
        checkChordAnswer(guess: "Triad Root Major", answer: chordType, buttonPressed: triadRootMajorButton)
    }
    
    @IBAction func triadRootMinorPressed(_ sender: Any) {
        checkChordAnswer(guess: "Triad Root Minor", answer: chordType, buttonPressed: triadRootMinorButton)
    }
    
    @IBAction func triad1stMajorPressed(_ sender: Any) {
        checkChordAnswer(guess: "Triad 1st Major", answer: chordType, buttonPressed: triad1stMajorButton)
    }
    
    @IBAction func triad1stMinorPressed(_ sender: Any) {
        checkChordAnswer(guess: "Triad 1st Minor", answer: chordType, buttonPressed: triad1stMinorButton)
    }
    
    @IBAction func triad2ndMajorPressed(_ sender: Any) {
        checkChordAnswer(guess: "Triad 2nd Major", answer: chordType, buttonPressed: triad2ndMajorButton)
    }
    
    @IBAction func triad2ndMinorPressed(_ sender: Any) {
        checkChordAnswer(guess: "Triad 2nd Minor", answer: chordType, buttonPressed: triad2ndMinorButton)
    }
    
    
    @IBAction func dim7thPressed(_ sender: Any) {
        checkChordAnswer(guess: "halfdim7", answer: chordType, buttonPressed: dim7thButton)
    }
    
    @IBAction func fulldim7thPressed(_ sender: Any) {
        checkChordAnswer(guess: "fulldim7", answer: chordType, buttonPressed: fulldim7thButton)
    }
    
    @IBAction func dom7thPressed(_ sender: Any) {
        checkChordAnswer(guess: "dom7", answer: chordType, buttonPressed: dom7thButton)
    }
    
    @IBAction func minor7thPressed(_ sender: Any) {
        checkChordAnswer(guess: "m7", answer: chordType, buttonPressed: minor7thButton)
    }
    
    @IBAction func major7thPressed(_ sender: Any) {
        checkChordAnswer(guess: "M7", answer: chordType, buttonPressed: major7thButton)
    }
    
    //Segue
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


