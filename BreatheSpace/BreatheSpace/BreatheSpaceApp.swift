//
//  BreatheSpaceApp.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

import SwiftUI
import SwiftData

@main
struct BreatheSpaceApp: App {
    @State private var audioService: AudioService
    @State private var sharedDataStore: SharedDataStore
    
    init() {
        _audioService = State(wrappedValue: AudioService())
        _sharedDataStore = State(wrappedValue: SharedDataStore())
    }
    
    var body: some Scene {
        WindowGroup {
            TabPage()
                .environment(audioService)
                .environment(sharedDataStore)
        }
    }
}

