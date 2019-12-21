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
            selectedIntervals.append(currentIntervals[selectedIntervals.count])
            
            settingsDelegate?.updateSettings(updatedIntervals: selectedIntervals, updatedMethods: selectedMethods)
            updateSettings()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.progressView.setProgress(self.CURR_ANSWER, animated: true)
            }
            
            
        }
    }
}
