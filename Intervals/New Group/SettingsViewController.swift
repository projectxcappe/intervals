//
//  SettingsViewController.swift
//  Intervals
//
//  Created by Cass Pangell on 12/18/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    func updateSettings(updatedIntervals: [String], updatedMethods: [String])
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
    
    @IBOutlet weak var ascButton: Toggle!
    @IBOutlet weak var decButton: Toggle!
    @IBOutlet weak var harmButton: Toggle!
    
    @IBOutlet var toggleButtonCollection: [Toggle]!
    
    var selectedMethods:[String]!
    var selectedIntervals:[String]!
    weak var SettingsDelegate: SettingsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Grab initial intervals
        selectedIntervals = IntervalsSelected.shared.intervals
        selectedMethods  = IntervalsSelected.shared.methods
        
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
        

    }
    
    @IBAction func close(_ sender: Any) {
        print(selectedIntervals)
        self.SettingsDelegate.updateSettings(updatedIntervals: selectedIntervals, updatedMethods: selectedMethods)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
