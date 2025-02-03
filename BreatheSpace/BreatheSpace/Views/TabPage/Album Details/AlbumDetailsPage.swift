import Inject
import SwiftUI

struct AlbumDetailsPage: View {
    @ObserveInjection private var inject
    @State private var viewModel: AlbumDetailsViewModel
    
    init(album: MeditationAlbum) {
        _viewModel = State(wrappedValue: AlbumDetailsViewModel(album: album))
    }
    
    var body: some View {
        List {
            // Album Header
            Section {
                albumHeader
            }
            
            // Track List
            Section {
                ForEach(viewModel.tracks, id: \.id) { track in
                    TrackRow(track: track)
                        .contentShape(Rectangle())
                        .onTapGesture { viewModel.selectedTrack = track }
                }
            }
        }
        .navigationTitle(viewModel.album.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $viewModel.selectedTrack) { track in
            MeditationDurationSheet(track: track)
        }
        .enableInjection()
    }
    
    private var albumHeader: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: viewModel.album.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(spacing: 8) {
                Text(viewModel.album.description)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 16) {
                    VStack {
                        Text("\(viewModel.album.trackCount)")
                            .font(.title2.bold())
                            .foregroundStyle(Color.accentDark)
                        Text("Tracks")
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack {
                        Text(formatDuration(viewModel.album.totalDuration))
                            .font(.title2.bold())
                            .foregroundStyle(Color.accentDark)
                        Text("Duration")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    private func formatDuration(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}