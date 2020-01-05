//
//  SettingsViewController.swift
//  Intervals
//
//  Created by Cass Pangell on 12/18/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    func updateSettings(updatedIntervals: [String], updatedMethods: [String], updatedChords: [String])
}

class SettingsViewController: UIViewController {

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
    
    @IBOutlet weak var major7thButton: Toggle!
    @IBOutlet weak var minor7thButton: Toggle!
    @IBOutlet weak var dom7thButton: Toggle!
    @IBOutlet weak var aug7thButton: Toggle!
    @IBOutlet weak var dim7thButton: Toggle!
    
    @IBOutlet weak var ascButton: Toggle!
    @IBOutlet weak var decButton: Toggle!
    @IBOutlet weak var harmButton: Toggle!

    
    @IBOutlet var toggleButtonCollection: [Toggle]!
    @IBOutlet var chordButtonCollection: [Toggle]!
    
    var selectedMethods:[String]!
    var selectedIntervals:[String]!
    var selectedChords:[String]!
    
    weak var SettingsDelegate: SettingsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Grab initial intervals
        selectedIntervals = IntervalsSelected.shared.intervals
        selectedMethods  = IntervalsSelected.shared.methods
        selectedChords = IntervalsSelected.shared.chords
        
        //Grab Intervals
        for i in selectedIntervals {
            for j in toggleButtonCollection {
                if i == j.titleLabel?.text {
                    j.isSelected = true
                }
            }
        }
        
        //Grab Methods
        for i in selectedMethods {
            for j in toggleButtonCollection {
                if i == j.titleLabel?.text {
                    j.isSelected = true
                }
            }
        }
        
        //Grab Chords
        for i in selectedChords {
            for j in chordButtonCollection {
                if i == j.titleLabel?.text {
                    j.isSelected = true
                }
            }
        }
        

    }
    
    @IBAction func close(_ sender: Any) {
        self.SettingsDelegate.updateSettings(updatedIntervals: selectedIntervals, updatedMethods: selectedMethods, updatedChords: selectedChords)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func minor2Pressed(_ sender: Any) {
        minor2Button.toggleTapped()
        
        if selectedIntervals.contains("m2") {
            selectedIntervals.remove(object: "m2")
        } else {
            selectedIntervals.append("m2")
        }
    }
    
    @IBAction func major2Pressed(_ sender: Any) {
        major2Button.toggleTapped()
        
        if selectedIntervals.contains("M2") {
            selectedIntervals.remove(object: "M2")
        } else {
            selectedIntervals.append("M2")
        }
        
    }
    
    @IBAction func minor3Pressed(_ sender: Any) {
        minor3Button.toggleTapped()
        
        if selectedIntervals.contains("m3") {
            selectedIntervals.remove(object: "m3")
        } else {
            selectedIntervals.append("m3")
        }
        
        
    }
    
    @IBAction func major3Pressed(_ sender: Any) {
        major3Button.toggleTapped()
        
        if selectedIntervals.contains("M3") {
            selectedIntervals.remove(object: "M3")
        } else {
            selectedIntervals.append("M3")
        }
        
        
    }
    
    @IBAction func perfect4Pressed(_ sender: Any) {
        perfect4Button.toggleTapped()
        
        if selectedIntervals.contains("P4") {
            selectedIntervals.remove(object: "P4")
        } else {
            selectedIntervals.append("P4")
        }
        
        
    }
    
    @IBAction func tritonePressed(_ sender: Any) {
        tritoneButton.toggleTapped()
        
        if selectedIntervals.contains("TT") {
            selectedIntervals.remove(object: "TT")
        } else {
            selectedIntervals.append("TT")
        }
        
        
    }
    
    @IBAction func perfect5Pressed(_ sender: Any) {
        perfect5Button.toggleTapped()
        
        if selectedIntervals.contains("P5") {
            selectedIntervals.remove(object: "P5")
        } else {
            selectedIntervals.append("P5")
        }
        
        
    }
    
    @IBAction func minor6Pressed(_ sender: Any) {
        minor6Button.toggleTapped()
        
        if selectedIntervals.contains("m6") {
            selectedIntervals.remove(object: "m6")
        } else {
            selectedIntervals.append("m6")
        }
        
    }
    
    @IBAction func major6Pressed(_ sender: Any) {
        major6Button.toggleTapped()
        
        if selectedIntervals.contains("M6") {
            selectedIntervals.remove(object: "M6")
        } else {
            selectedIntervals.append("M6")
        }
        
    }
    
    @IBAction func minor7Pressed(_ sender: Any) {
        minor7Button.toggleTapped()
        
        if selectedIntervals.contains("m7") {
            selectedIntervals.remove(object: "m7")
        } else {
            selectedIntervals.append("m7")
        }
        
    }
    
    @IBAction func major7Pressed(_ sender: Any) {
        major7Button.toggleTapped()
        
        if selectedIntervals.contains("M7") {
            selectedIntervals.remove(object: "M7")
        } else {
            selectedIntervals.append("M7")
        }
        
    }
    
    @IBAction func perfect8Pressed(_ sender: Any) {
        perfect8Button.toggleTapped()
        
        if selectedIntervals.contains("P8") {
            selectedIntervals.remove(object: "P8")
        } else {
            selectedIntervals.append("P8")
        }
        
    }
    
    @IBAction func ascPressed(_ sender: Any) {
        ascButton.toggleTapped()
        
        if selectedMethods.contains("Ascending") {
            selectedMethods.remove(object: "Ascending")
        } else {
            selectedMethods.append("Ascending")
        }
    }
    
    
    @IBAction func decPressed(_ sender: Any) {
        decButton.toggleTapped()
        
        if selectedMethods.contains("Decending") {
            selectedMethods.remove(object: "Decending")
        } else {
            selectedMethods.append("Decending")
        }
    }
    
    @IBAction func harmPressed(_ sender: Any) {
        harmButton.toggleTapped()
        
        if selectedMethods.contains("Harmonic") {
            selectedMethods.remove(object: "Harmonic")
        } else {
            selectedMethods.append("Harmonic")
        }
    }
    
    @IBAction func triadRootMajorPressed(_ sender: Any) {
        triadRootMajorButton.toggleTapped()
        
        if selectedChords.contains("Triad Root Major") {
            selectedChords.remove(object: "Triad Root Major")
        } else {
            selectedChords.append("Triad Root Major")
        }
    }
    
    @IBAction func triadRootMinorPressed(_ sender: Any) {
        triadRootMinorButton.toggleTapped()
        
        if selectedChords.contains("Triad Root Minor") {
            selectedChords.remove(object: "Triad Root Minor")
        } else {
            selectedChords.append("Triad Root Minor")
        }
    }
    
    @IBAction func triad1stMajorPressed(_ sender: Any) {
        triad1stMajorButton.toggleTapped()
        
        if selectedChords.contains("Triad 1st Major") {
            selectedChords.remove(object: "Triad 1st Major")
        } else {
            selectedChords.append("Triad 1st Major")
        }
    }
    
    @IBAction func triad1stMinorPressed(_ sender: Any) {
        triad1stMinorButton.toggleTapped()
        
        if selectedChords.contains("Triad 1st Minor") {
            selectedChords.remove(object: "Triad 1st Minor")
        } else {
            selectedChords.append("Triad 1st Minor")
        }
    }
    
    @IBAction func triad2nsMajorPressed(_ sender: Any) {
        triad2ndMajorButton.toggleTapped()
        
        if selectedChords.contains("Triad 2nd Major") {
            selectedChords.remove(object: "Triad 2nd Major")
        } else {
            selectedChords.append("Triad 2nd Major")
        }
    }
    
    @IBAction func triad2ndMinorPressed(_ sender: Any) {
        triad2ndMinorButton.toggleTapped()
        
        if selectedChords.contains("Triad 2nd Minor") {
            selectedChords.remove(object: "Triad 2nd Minor")
        } else {
            selectedChords.append("Triad 2nd Minor")
        }
    }
    
    @IBAction func major7thPressed(_ sender: Any) {
        major7thButton.toggleTapped()
        
        if selectedChords.contains("M7") {
            selectedChords.remove(object: "M7")
        } else {
            selectedChords.append("M7")
        }
    }
    
    @IBAction func minor7thPressed(_ sender: Any) {
        minor7thButton.toggleTapped()

        if selectedChords.contains("m7") {
            selectedChords.remove(object: "m7")
        } else {
            selectedChords.append("m7")
        }
    }
    
    @IBAction func dom7thPressed(_ sender: Any) {
        dom7thButton.toggleTapped()
        
        if selectedChords.contains("dom7") {
            selectedChords.remove(object: "dom7")
        } else {
            selectedChords.append("dom7")
        }
    }
    
    @IBAction func aug7thPressed(_ sender: Any) {
        aug7thButton.toggleTapped()

        if selectedChords.contains("aug7") {
            selectedChords.remove(object: "aug7")
        } else {
            selectedChords.append("aug7")
        }
    }
    
    @IBAction func dim7thPressed(_ sender: Any) {
        dim7thButton.toggleTapped()

        if selectedChords.contains("halfdim7") {
            selectedChords.remove(object: "halfdim7")
        } else {
            selectedChords.append("halfdim7")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
