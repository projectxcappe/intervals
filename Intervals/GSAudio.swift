//
//  GSAudio.swift
//  Intervals
//
//  Created by Cass Pangell on 12/16/19.
//  Copyright © 2019 Cass Pangell. All rights reserved.
//

/*
 Adapted from Oliver Wilkinson
 The class is a singleton, so to access the class use:
 
 GSAudio.sharedInstance
 for example, to play a sound you would call:
 
 GSAudio.sharedInstance.playSound("AudioFileName")
 and to play a number of sounds at once:
 
 GSAudio.sharedInstance.playSounds("AudioFileName1", "AudioFileName2")
 or you could load up the sounds in an array somewhere and call the playSounds function that accepts an array:
 
 let sounds = ["AudioFileName1", "AudioFileName2"]
 GSAudio.sharedInstance.playSounds(sounds)
 I also added a playSounds function that allows you to delay each sound being played in a cascade kind of format. So:
 
 let soundFileNames = ["SoundFileName1", "SoundFileName2", "SoundFileName3"]
 GSAudio.sharedInstance.playSounds(soundFileNames, withDelay: 1.0)
 would play sound2 a second after sound1, then sound3 would play a second after sound2 etc.
 */

import AVFoundation

//This class allows multiple occurances of audio to play co-currently
class GSAudio: NSObject, AVAudioPlayerDelegate {
    
    static let sharedInstance = GSAudio()
    
    private override init() { }
    
    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []
    
    func playSound(soundFileName: String) {
        
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: "aifc") else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)
        
        if let player = players[soundFileNameURL] { //player for sound has been found
            
            if !player.isPlaying { //player is not in use, so use that one
                player.prepareToPlay()
                player.play()
            } else { // player is in use, create a new, duplicate, player and use that instead
                
                do {
                    let duplicatePlayer = try AVAudioPlayer(contentsOf: soundFileNameURL)
                    
                    duplicatePlayer.delegate = self
                    //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing
                    
                    duplicatePlayers.append(duplicatePlayer)
                    //add duplicate to array so it doesn't get removed from memory before finishing
                    
                    duplicatePlayer.prepareToPlay()
                    duplicatePlayer.play()
                } catch let error {
                    print(error.localizedDescription)
                }
                
            }
        } else { //player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func playSounds(soundFileNames: [String]) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }
    
    func playSounds(soundFileNames: String...) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }
    
    func playSounds(soundFileNames: [String], withDelay: Double) { //withDelay is in seconds
        for (index, soundFileName) in soundFileNames.enumerated() {
            let delay = withDelay * Double(index)
            let _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName": soundFileName], repeats: false)
        }
    }
    
    @objc func playSoundNotification(_ notification: NSNotification) {
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            playSound(soundFileName: soundFileName)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = duplicatePlayers.firstIndex(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
    
}
