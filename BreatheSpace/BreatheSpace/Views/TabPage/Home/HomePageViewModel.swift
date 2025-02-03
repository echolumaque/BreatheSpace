//
//  HomePageViewModel.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

import SwiftUI
import Observation

@MainActor
@Observable
class HomePageViewModel {
    var randomAlbums: [MeditationAlbum] = []
    var errorMessage: String?
    var isLoading = false
    
    func onAppear() async {
        await loadMeditationContent()
    }
    
    private func loadMeditationContent() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let url = Bundle.main.url(forResource: "meditation_content", withExtension: "json") else {
                errorMessage = "Could not find meditation_content.json"
                return
            }
            
            let data = try Data(contentsOf: url)
            let meditationContent = try JSONDecoder().decode(MeditationContent.self, from: data)
            let albums = meditationContent.featuredAlbums
            
            randomAlbums = Array(albums.shuffled().prefix(5))
        } catch {
            errorMessage = "Error loading meditation content: \(error.localizedDescription)"
        }
    }
}