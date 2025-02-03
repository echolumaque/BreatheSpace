//
//  MusicPage.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

import SwiftUI

struct MusicPage: View {
    @Environment(SharedDataStore.self) private var sharedDataStore
    @State var vm: MusicPageViewModel
    
    init() {
        _vm = State(wrappedValue: MusicPageViewModel())
    }
    
    var body: some View {
        ScrollView {
            if vm.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = vm.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Genre Selection
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 20) {
                        ForEach(MusicType.allCases) { musicType in
                            Button {
                                vm.selectedMusicType = musicType
                            } label: {
                                Text(musicType.rawValue)
                                    .padding(.vertical)
                                    .foregroundStyle(vm.selectedMusicType == musicType ? Color.accentDark : .gray)
                                    .overlay {
                                        GeometryReader { geometry in
                                            Rectangle()
                                                .frame(width: geometry.size.width, height: 5)
                                                .foregroundStyle(vm.selectedMusicType == musicType ? Color.accentDark : .clear)
                                                .position(x: geometry.size.width / 2, y: geometry.size.height)
                                        }
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .zIndex(1)

                // Filtered Tracks Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                    ForEach(vm.filteredTracks) { track in
                        Button {
                            vm.selectedTrack = track
                        } label: {
                            AsyncImage(url: URL(string: track.imageUrl)) { image in
                                GeometryReader { geometry in 
                                    image
                                        .resizable()
                                        .scaledToFill()

                                    Rectangle()
                                        .fill(.black.opacity(0.3))

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(track.title)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                        
                                        Text(track.formattedDuration)
                                            .font(.subheadline)
                                            .foregroundStyle(.white.opacity(0.8))
                                    }
                                    .padding(8)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                }
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(white: 0.9))
                                    .overlay {
                                        ProgressView()
                                    }
                            }
                            .frame(height: 100)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top)

                // Featured Albums
                if !vm.featuredAlbumsForCurrentGenre.isEmpty {
                    Group {
                        Text("Featured Albums")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach(vm.featuredAlbumsForCurrentGenre) { album in
                                    Button {
                                        // vm.selectAlbum(withId: album.id)
                                        sharedDataStore.pages.append(.albumDetails(album: album))
                                    } label: {
                                        VStack(alignment: .leading) {
                                            AsyncImage(url: URL(string: album.imageUrl)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 160, height: 250)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                            } placeholder: {
                                                Rectangle()
                                                    .fill(Color(white: 0.9))
                                                    .frame(width: 160, height: 250)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    .overlay {
                                                        ProgressView()
                                                    }
                                            }
                                                    
                                            Text(album.title)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                            
                                            Text("\(album.formattedTotalDuration) • \(album.trackCount) tracks")
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }
        }
        .padding(.horizontal)
        .clipped()
        .task { await vm.onAppear() }
        .sheet(item: $vm.selectedTrack) { track in
            MeditationDurationSheet(track: track)
        }
    }
}

#Preview {
    MusicPage()
}
