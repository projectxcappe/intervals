//
//  Gamify.swift
//  Intervals
//
//  Created by Cass Pangell on 12/21/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

import Foundation

extension ViewController {
    //Gamify and Progress Bar
    func updateProgress(status:Answer) {
        
        switch status {
        case .Correct:
            CURR_ANSWER += 0.1
        case .Incorrect:
            if CURR_ANSWER >= 0.3 {
                CURR_ANSWER -= 0.3
            } else {
                CURR_ANSWER = 0
            }
        case .Setup:
            CURR_ANSWER = 1.0
            progressView.setProgress(CURR_ANSWER, animated: false)
            CURR_ANSWER = 0.0
            
        }
        
        self.progressView.setProgress(self.CURR_ANSWER, animated: true)
        
        //Check to see if Max points and reset score and add next interval
        if CURR_ANSWER >= MAX_ANSWER {
            correctLabel.text = "BOOM!"
            CURR_ANSWER = 0.0
            
            let currentIntervals = IntervalsSelected.shared.allIntervals!
            if currentIntervals.count != currentIntervals.capacity {
                selectedIntervals.append(currentIntervals[selectedIntervals.count])
                settingsDelegate?.updateSettings(updatedIntervals: selectedIntervals, updatedMethods: selectedMethods, updatedChords: selectedChords)
                updateSettings()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.progressView.setProgress(self.CURR_ANSWER, animated: true)
                if self.CURR_ANSWER == 1.0 {
                     self.correctLabel.text = "FINISHED!"
                }
            }
            
            
        }
    }

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.correctLabel.alpha = 0.0
        }

    }
    
    func checkChordAnswer(guess:String, answer:String, quality:ChordQuality, buttonPressed:Toggle) {
        print(guess, answer, quality, buttonPressed.titleLabel?.text)
        
//        if guess == answer {
//            //Reset currentIntervalBeingPlayed, display Correct! label
//            //Disable play button temporarily
//            replayCurrentInterval = false
//            beginButton.isEnabled = false
//            self.correctLabel.text = "Correct!"
//            self.correctLabel.alpha = 1.0
//
//            //Update progress bar
//            self.updateProgress(status: .Correct)
//
//            //play new interval, re-enable play button
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.beginButton.isEnabled = true
//                self.playChord()
//                self.updateSettings()
//            }
//        } else {
//            //Disable guess, demote progress
//            buttonPressed.isEnabled = false
//            self.updateProgress(status: .Incorrect)
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.correctLabel.text = "Incorrect."
//                self.correctLabel.alpha = 1.0
//            }
//
//            replayCurrentInterval = true
//        }
    }
}
