//
//  MeditationAlbum.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/29/25.
//

import Foundation

struct MeditationAlbum: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let imageUrl: String
    let description: String
    let totalDuration: Int
    let trackCount: Int
    let genre: MusicType
    let tracks: [String] // References to MeditationTrack IDs
}

// MARK: - Helper Extensions
extension MeditationAlbum {
    // var formattedTotalDuration: String {
    //     let minutes = totalDuration / 60
    //     let seconds = totalDuration % 60
    //     return String(format: "%d:%02d", minutes, seconds)
    // }

    var formattedTotalDuration: String {
        return "\(totalDuration / 60) mins"
    }
}