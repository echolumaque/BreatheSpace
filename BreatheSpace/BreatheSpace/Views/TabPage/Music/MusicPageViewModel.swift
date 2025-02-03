//
//  MusicPageViewModel.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

import SwiftUI
import Observation

@MainActor
@Observable
class MusicPageViewModel {
    var meditationContent: MeditationContent?
    var filteredTracks: [MeditationTrack] = []
    var selectedAlbum: MeditationAlbum?
    var selectedTrack: MeditationTrack?
    var isShowingDurationSheet = false
    
    var selectedMusicType: MusicType = .focus {
        didSet {
            filterTracksByType()
        }
    }
    
    var featuredAlbumsForCurrentGenre: [MeditationAlbum] {
        meditationContent?.featuredAlbums.filter { $0.genre == selectedMusicType } ?? []
    }
    
    var selectedAlbumTracks: [MeditationTrack] {
        guard let selectedAlbum = selectedAlbum,
              let content = meditationContent else { return [] }
        
        return selectedAlbum.tracks.compactMap { trackId in
            content.music.first { $0.id == trackId }
        }
    }
    
    var errorMessage: String?
    var isLoading = false

    func onAppear() async {
        await loadMeditationContent()
    }
    
    // MARK: - Content Loading
    private func loadMeditationContent() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let url = Bundle.main.url(forResource: "meditation_content", withExtension: "json") else {
                errorMessage = "Could not find meditation_content.json"
                return
            }
            
            let data = try Data(contentsOf: url)
            meditationContent = try JSONDecoder().decode(MeditationContent.self, from: data)
            filterTracksByType()
        } catch {
            errorMessage = "Error loading meditation content: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Content Filtering
    private func filterTracksByType() {
        filteredTracks = meditationContent?.music.filter { $0.genre == selectedMusicType } ?? []
    }
    
    // MARK: - Album Selection
    func selectAlbum(withId id: String) {
        selectedAlbum = meditationContent?.featuredAlbums.first { $0.id == id }
    }
    
    func clearAlbumSelection() {
        selectedAlbum = nil
    }
}
