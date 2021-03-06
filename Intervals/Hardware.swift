//
//  Hardware.swift
//  Intervals
//
//  Created by Cass Pangell on 12/15/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//


import Foundation
import UIKit
import AVFoundation

//Allows the settings to be saved from Settings to Main View
//Defaults listed below
public class IntervalsSelected {
    public var intervals: [String]? = []
    public var methods: [String]? = ["Ascending"]
    public var chords: [String]? = ["M7", "m7", "dom7", "fulldim7", "halfdim7"]
    public var allIntervals: [String]? = ["m2", "M2", "m3", "M3", "P4", "TT", "P5", "m6", "M6", "m7", "M7", "P8"]
    public var allChords: [String]? = ["Triad Root", "Triad 1st", "Triad 2nd", "M7", "m7", "dom7", "fulldim7", "halfdim7"]
    public static let shared = IntervalsSelected()
}

//Loading JSON Interval File
func loadIntervalFile() {
    let filename = "Intervals"
    let bundle = Bundle.main
    let path = bundle.path(forResource: filename, ofType: "json")
    do {
        let content = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
    } catch {
        print("Inverval File Not Found")
    }
}

func loadIntervalFile(filename fileName: String) -> IntervalData? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.interval_data
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

//Play Sound
extension ViewController {
    func playIntervalSound(root:String, secondNote:String, interval:String) {
        print("Root: "+root+" secondNote: "+secondNote)
        GSAudio.sharedInstance.playSound(soundFileName: root)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            GSAudio.sharedInstance.playSound(soundFileName: secondNote)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.colorSwitch.isOn {
                self.displayIntervalColor(interval: interval)
            }
        }
    }
    
    func playHarmonicIntervalSound(root:String, secondNote:String, interval:String) {
        print("Root: "+root+" secondNote: "+secondNote)
        
        GSAudio.sharedInstance.playSound(soundFileName: root)
        GSAudio.sharedInstance.playSound(soundFileName: secondNote)
        
        if colorSwitch.isOn {
            displayIntervalColor(interval: interval)
        }
        
    }
    
    func playIntervalSong(song:String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            GSAudio.sharedInstance.playSound(soundFileName: song)
        }

        print("Song "+song)
    }
    
    func playChordSounds(chordNotes:[String], chordQaulity:String) {
        print(chordNotes, chordQaulity)
 
        //Play Together
        GSAudio.sharedInstance.playSounds(soundFileNames: chordNotes)
        
        if triadSwitch.isOn {
            //Play Separately
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                var interval:[String]
                if chordQaulity == "Triad Root Major" || chordQaulity == "Triad Root Minor" {
                 interval = [chordNotes[0], chordNotes[1], chordNotes[2]]
                    GSAudio.sharedInstance.playSounds(soundFileNames: interval, withDelay: 0.75)
                } else if chordQaulity == "Triad 2nd Major" || chordQaulity == "Triad 2nd Minor" {
                    interval = [chordNotes[0], chordNotes[2], chordNotes[1]]
                    GSAudio.sharedInstance.playSounds(soundFileNames: interval, withDelay: 0.75)
                } else if chordQaulity == "Triad 3rd Major" || chordQaulity == "Triad 3rd Minor" {
                    interval = [chordNotes[2], chordNotes[1], chordNotes[0], chordNotes[1], chordNotes[2]]
                    GSAudio.sharedInstance.playSounds(soundFileNames: interval, withDelay: 0.75)
                } else { //seventh
                   //don't play separately
                }
                
            }
        }

        if colorSwitch.isOn {
            displayChordColor(chordQuality: chordQaulity)
        }
    }
    
    func toggleButtons(time:Double) {

        //disable buttons for a moment to let audio play
        self.beginButton.isEnabled = false
        
        for button in self.toggleButtonCollection {
            button.isEnabled = false
        }
        
        for button in self.chordsButtonCollection {
            button.isEnabled = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.updateSettings() //reset the buttons
            self.beginButton.isEnabled = true
        }
    }
    
    func displayIntervalColor(interval:String) {
        
        let currentStructure:[String:UIColor] = ["m2":UIColor.minor2, "M2":UIColor.major2, "m3":UIColor.minor3, "M3":UIColor.major3, "P4":UIColor.perfect4, "TT":UIColor.tritone, "P5":UIColor.perfect5, "m6":UIColor.minor6, "M6":UIColor.major6, "m7":UIColor.minor7, "M7":UIColor.major7, "P8":UIColor.perfect8]
        
        colorView.backgroundColor = currentStructure[interval]
        colorView.alpha = 0.0

        UIView.animate(withDuration: 1.0, animations: {
            self.colorView.alpha = 1.0
        }) { (true) in
            UIView.animate(withDuration: 1.0, animations: {
                self.colorView.alpha = 0.0
            })
        }

    }
    
    func displayChordColor(chordQuality:String) {
        
        let currentStructure:[String:UIColor] = ["Triad Root Major":UIColor.triadRootMajor, "Triad Root Minor":UIColor.triadRootMinor, "Triad 1st Major":UIColor.triad1stMajor, "Triad 1st Minor":UIColor.triad1stMinor, "Triad 2nd Major":UIColor.triad2ndMajor, "Triad 2nd Minor":UIColor.triad2ndMinor, "M7":UIColor.seventhMajor, "m7":UIColor.seventhMinor, "dom7":UIColor.seventhDom, "halfdim7":UIColor.seventhHalfDim, "fulldim7":UIColor.seventhFullDim]
        
        colorView.backgroundColor = currentStructure[chordQuality]
        colorView.alpha = 0.0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.colorView.alpha = 1.0
        }) { (true) in
            UIView.animate(withDuration: 2.0, animations: {
                self.colorView.alpha = 0.0
            })
        }
        
    }
}

//Extensions
extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
}


