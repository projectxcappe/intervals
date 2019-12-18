//
//  Hardware.swift
//  Intervals
//
//  Created by Cass Pangell on 12/15/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//


import Foundation
import AVFoundation

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

func loadIntervalFile(filename fileName: String) -> [Intervals]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.interval_dec
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

//Play Sound
extension ViewController {
    func playIntervalSound(root:String, interval:String) {
        GSAudio.sharedInstance.playSound(soundFileName: root)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            GSAudio.sharedInstance.playSound(soundFileName: interval)
        }
    }
    
    func playHarmonicIntervalSound(root:String, interval:String) {
        GSAudio.sharedInstance.playSound(soundFileName: root)
        GSAudio.sharedInstance.playSound(soundFileName: interval)
    }
}


