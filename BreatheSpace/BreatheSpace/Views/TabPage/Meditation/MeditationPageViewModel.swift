//
//  MeditationPageViewModel.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import SwiftUI

@MainActor
@Observable
class MeditationPageViewModel {
    var track: MeditationTrack
    var duration: TimeInterval
    var isBreathingIn = false
    
    init(track: MeditationTrack, duration: TimeInterval) {
        self.track = track
        self.duration = duration
    }
    
    func toggleBreathing() {
        isBreathingIn.toggle()
    }
}
