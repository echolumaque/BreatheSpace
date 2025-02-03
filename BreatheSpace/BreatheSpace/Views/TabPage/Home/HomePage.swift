//
//  HomePage.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

import SwiftUI

struct HomePage: View {
    @Environment(SharedDataStore.self) private var sharedDataStore
    @State private var vm: HomePageViewModel
    @State private var selectedAlbum: MeditationAlbum?
    private let featured: [(title: String, url: String)] = [
        ("Serenity", "https://img.freepik.com/free-vector/flat-design-adventure-background_23-2149041603.jpg?t=st=1738052405~exp=1738056005~hmac=1d946a47811d04c49e0b3d10ce6e94317fdb4275968b851ca6aa5520455fcc6b&w=1800"),
        ("Tranquil", "https://img.freepik.com/free-vector/flat-design-adventure-background_23-2149059266.jpg?t=st=1738052629~exp=1738056229~hmac=bbff7c6d8e39d3ff9aa13fc407a665ce89be9316630bed1d59bf2c000c94be57&w=1800"),
        ("Harmony", "https://img.freepik.com/free-vector/drawn-trees-winter-time_23-2148721517.jpg?t=st=1738052649~exp=1738056249~hmac=2da22386edbf15de4b2de7caaf1e83899a6bedadfe308adf477f24cf797b2a96&w=1800"),
        ("Peace", "https://img.freepik.com/free-vector/organic-farming-concept-with-girl-goose_23-2148425657.jpg?t=st=1738052669~exp=1738056269~hmac=bf9a8f06c55abad39034bbc95e1625b739911d4b1905f0ba969a1a03af822fa7&w=1800"),
        ("Calm", "https://img.freepik.com/free-vector/realistic-mountain-landscape-illustration_23-2149156110.jpg?t=st=1738052693~exp=1738056293~hmac=26e31735b2620a1f7724385040ab5c2fa06a42d580dc8500c69b4282abde05aa&w=1800")
    ]
    
    init() {
        _vm = State(wrappedValue: HomePageViewModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    AsyncImage(url: URL(string: "https://www.shutterstock.com/image-vector/portrait-young-asian-man-avatar-600nw-2172539639.jpg")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.capsule)
                            .frame(maxWidth: .infinity, maxHeight: 150)
                            
                    } placeholder: {
                        Rectangle()
                            .fill(Color(red: 0.9, green: 0.95, blue: 0.93))
                            .frame(width: 280, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                Text("Hi, Echo!")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)

                Text("You've been mindful for 12 days in a row. Keep it up!\nUnlock more features with Premium. Start free trial.")
                    .font(.system(size: 18))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 4)

                    Button {
                        print("Button pressed")
                    } label: {
                        Text("Upgrade")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.accentDark)
                            .clipShape(.capsule)
                            .padding(.horizontal)
                    }
                    .padding(.top, 4)
                }

                Group {
                    Text("Quick actions")
                    .font(.title)
                    .fontWeight(.bold)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                        ForEach([
                            ("Start", "play.circle.fill"),
                            ("Daily Calm", "clock.fill"),
                            ("Stats", "chart.xyaxis.line"),
                            ("Mindfulness", "brain.head.profile.fill")
                        ], id: \.0) { title, icon in
                            Button {
                                print("\(title) pressed")
                            } label: {
                                Label {
                                    Text(title)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                } icon: {
                                    Image(systemName: icon)
                                        .font(.system(size: 24))
                                        .foregroundStyle(.white)
                                }
                                .padding(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 80)
                                .background(Color.accentDark)
                                .clipShape(.rect(cornerRadius: 12))
                            }
                        }
                    }
                }
                .padding(.top, 12)

                Group {
                    Text("Featured")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            if vm.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else if let error = vm.errorMessage {
                                Text(error)
                                    .foregroundStyle(.red)
                            } else {
                                ForEach(vm.randomAlbums) { album in
                                    Button {
                                        sharedDataStore.pages.append(.albumDetails(album: album))
                                    } label: {
                                        VStack(alignment: .leading, spacing: 8) {
                                            AsyncImage(url: URL(string: album.imageUrl)) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 160, height: 250)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            
                                            Group {
                                                Text(album.title)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .lineLimit(1)
                                                    .foregroundStyle(.primary)
                                                
                                                Text(album.description)
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                                    .lineLimit(1)
                                            }
                                            .frame(width: 160, alignment: .leading)
                                        } 
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
        .clipped()
        .task { await vm.onAppear() }
    }
}

struct FeaturedAlbumCard: View {
    let album: MeditationAlbum
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: album.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 160, height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(album.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(album.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .frame(width: 160)
        }
    }
}

#Preview {
    HomePage()
}
