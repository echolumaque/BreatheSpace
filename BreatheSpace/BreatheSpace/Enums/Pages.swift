import Foundation

enum Pages: Hashable {
    case albumDetails(album: MeditationAlbum)
    case meditation(track: MeditationTrack, duration: TimeInterval)
}
