//
//  MeditationContent.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/29/25.
//

import Foundation

// MARK: - Main Content Structure
struct MeditationContent: Codable {
    let music: [MeditationTrack]
    let featuredAlbums: [MeditationAlbum]
    
    enum CodingKeys: String, CodingKey {
        case music
        case featuredAlbums = "featured_albums"
    }
}