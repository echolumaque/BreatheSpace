//
//  BreathingStyle.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

enum BreathingStyle: String, CaseIterable, Identifiable, Codable {
    case boxBreathing = "Box Breathing"
    case deepCalm = "Deep Calm"
    case custom = "Custom"
    
    var id: Self { self }
}
