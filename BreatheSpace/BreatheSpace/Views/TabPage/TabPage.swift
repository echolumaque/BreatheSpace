//
//  TabPage.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

@_exported import Inject
import SwiftUI

struct TabPage: View {
    @Environment(SharedDataStore.self) private var sharedDataStore
    @ObserveInjection var inject
    @State private var vm: TabPageViewModel
    
    init() {
        _vm = State(wrappedValue:  TabPageViewModel())
    }
    
    var body: some View {
        @Bindable var bindableSharedDataStore = sharedDataStore
        
        NavigationStack(path: $bindableSharedDataStore.pages) {
            TabView {
                Tab(BreatheSpaceTab.home.rawValue, systemImage: BreatheSpaceTab.home.icon) {
                    HomePage()
                }

                Tab(BreatheSpaceTab.music.rawValue, systemImage: BreatheSpaceTab.music.icon) {
                    MusicPage()
                }

                Tab(BreatheSpaceTab.profile.rawValue, systemImage: BreatheSpaceTab.profile.icon) {
                    ProfilePage()
                }
            }
            .tint(Color.accentDark)
            .navigationDestination(for: Pages.self) { page in
                switch page {
                case .albumDetails(let album):
                    AlbumDetailsPage(album: album)
                    
                case .meditation(let track, let duration):
                    MeditationPage(track: track, duration: duration)
                }
            }
        }
        .enableInjection()
    }
}

#Preview {
    let swiftDataManager = SwiftDataManager()
    
    return TabPage()
}
