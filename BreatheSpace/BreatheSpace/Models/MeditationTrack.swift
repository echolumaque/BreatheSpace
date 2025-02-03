//
//  MeditationTrack.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/29/25.
//

import Foundation

struct MeditationTrack: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let duration: Int
    let genre: MusicType
    let imageUrl: String
    let description: String
}

// MARK: - Helper Extensions
extension MeditationTrack {
    var formattedDuration: String {
        let minutes = duration / 60
        let seconds = duration % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
