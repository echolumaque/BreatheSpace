import Foundation

@MainActor
@Observable
class AlbumDetailsViewModel {
    let album: MeditationAlbum
    var selectedTrack: MeditationTrack?
    var tracks: [MeditationTrack] = []
    
    init(album: MeditationAlbum) {
        self.album = album
        loadTracks()
    }
    
    private func loadTracks() {
        guard let url = Bundle.main.url(forResource: "meditation_content", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let content = try? JSONDecoder().decode(MeditationContent.self, from: data) else {
            return
        }
        
        // Filter tracks based on album's track IDs
        tracks = content.music.filter { track in
            album.tracks.contains(track.id)
        }
    }
}
