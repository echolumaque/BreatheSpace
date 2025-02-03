//
//  AudioService.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import Foundation
import AVFoundation

@Observable
class AudioService {
    private var player: AVAudioPlayer?
    var isPlaying = false
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "ambientBirds", withExtension: "wav") else {
            print("Could not find ambientBirds.wav")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Loop indefinitely
            player?.play()
            isPlaying = true
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func playSound(named fileName: String, withExtension ext: String = "wav") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: ext) else {
            print("Could not find \(fileName).\(ext)")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Loop indefinitely
            player?.play()
            isPlaying = true
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func pauseSound() {
        player?.pause()
        isPlaying = false
    }
    
    func stopSound() {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
        player = nil
    }
}
