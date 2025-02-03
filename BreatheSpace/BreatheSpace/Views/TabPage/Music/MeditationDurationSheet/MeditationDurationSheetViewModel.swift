//
//  MeditationDurationSheetViewModel.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/29/25.
//

import SwiftUI
import Observation

@MainActor
@Observable
class MeditationDurationSheetViewModel {
    let track: MeditationTrack
    var minutes: Int = 5
    var seconds: Int = 0
    
    var totalSeconds: Int {
        (minutes * 60) + seconds
    }
    
    var formattedDuration: String {
        String(format: "%d:%02d", minutes, seconds)
    }
    
    init(track: MeditationTrack) {
        self.track = track
    }
    
    func startMeditation() {
        // TODO: Implement meditation start logic
        print("Starting meditation for \(formattedDuration) with track: \(track.title)")
    }
}
