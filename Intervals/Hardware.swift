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
    public var intervals: [String]? = ["m2", "M2"]
    public var methods: [String]? = ["Ascending"]
    public var allIntervals: [String]? = ["m2", "M2", "m3", "M3", "P4", "TT", "P5", "m6", "M6", "m7", "M7", "P8"]
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
        displayIntervalColor(interval: interval)
    }
    
    func playHarmonicIntervalSound(root:String, secondNote:String, interval:String) {
        print("Root: "+root+" secondNote: "+secondNote)
        
        GSAudio.sharedInstance.playSound(soundFileName: root)
        GSAudio.sharedInstance.playSound(soundFileName: secondNote)
        displayIntervalColor(interval: interval)
        
    }
    
    func playIntervalSong(song:String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            GSAudio.sharedInstance.playSound(soundFileName: song)
        }
        print("Song "+song)
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
}

//Extensions
extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
}

extension ViewController {
    func checkAnswer(guess:String, answer:String, method: String, buttonPressed:Toggle) {

        if guess == answer {
            //Reset currentIntervalBeingPlayed, display Correct! label
            //Disable play button temporarily
            replayCurrentInterval = false
            beginButton.isEnabled = false
            self.correctLabel.text = "Correct!"
            self.correctLabel.alpha = 1.0
            
            //Update progress bar
            self.updateProgress(status: .Correct)
            
            //play new interval, re-enable play button
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.beginButton.isEnabled = true
                self.playInterval()
                self.updateSettings()
            }
        } else {
            //Disable guess, demote progress
            buttonPressed.isEnabled = false
            self.updateProgress(status: .Incorrect)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.correctLabel.text = "Incorrect."
                self.correctLabel.alpha = 1.0
            }
            
            replayCurrentInterval = true
            //Get interval song
            var songToBePlayed:String!

            if method == "Ascending" {
                let ascendingSongs = intervalSongs.SongAscending
                //Stick all the songs in a dict
                let currentStructure:[String:String] = ["m2":ascendingSongs.m2, "M2":ascendingSongs.M2, "m3":ascendingSongs.m3, "M3":ascendingSongs.M3, "P4":ascendingSongs.P4, "TT":ascendingSongs.TT, "P5":ascendingSongs.P5, "m6":ascendingSongs.m6, "M6":ascendingSongs.M6, "m7":ascendingSongs.m7, "M7":ascendingSongs.M7, "P8":ascendingSongs.P8]
                
                songToBePlayed = currentStructure[answer]
                
            } else { //Decending
                let decendingSongs = intervalSongs.SongDecending
                //Stick all the songs in a dict
                let currentStructure:[String:String] = ["m2":decendingSongs.m2, "M2":decendingSongs.M2, "m3":decendingSongs.m3, "M3":decendingSongs.M3, "P4":decendingSongs.P4, "TT":decendingSongs.TT, "P5":decendingSongs.P5, "m6":decendingSongs.m6, "M6":decendingSongs.M6, "m7":decendingSongs.m7, "M7":decendingSongs.M7, "P8":decendingSongs.P8]
                
                songToBePlayed = currentStructure[answer]
            }
            
            playIntervalSong(song: songToBePlayed)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.correctLabel.alpha = 0.0
        }
    }
}
