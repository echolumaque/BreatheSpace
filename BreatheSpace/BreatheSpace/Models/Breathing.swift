//
//  Breathing.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

import Foundation
import SwiftData

@Model
class Breathing {
    var breathingStyle: BreathingStyle = BreathingStyle.boxBreathing
    var duration: Double = 0
    var fileName: URL? = URL(string: "")
    var soundName: String = ""
    
    init(
        breathingStyle: BreathingStyle,
        duration: Double,
        fileName: URL? = nil,
        soundName: String
    ) {
        self.breathingStyle = breathingStyle
        self.duration = duration
        self.fileName = fileName
        self.soundName = soundName
    }
}
