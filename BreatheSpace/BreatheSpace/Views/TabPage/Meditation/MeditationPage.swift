//
//  MeditationPage.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import Inject
import SwiftUI

struct MeditationPage: View {
    @ObserveInjection private var inject
    @Environment(AudioService.self) private var audioService
    @State private var vm: MeditationPageViewModel
    
    init(track: MeditationTrack, duration: TimeInterval) {
        _vm = State(wrappedValue: MeditationPageViewModel(track: track, duration: duration))
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // Track Image with Breathing Animation
            ZStack {
                Circle()
                    .fill(Color.accentSubtle)
                    .frame(width: 320, height: 320)
                    .scaleEffect(vm.isBreathingIn ? 1.2 : 1.0)
                
                AsyncImage(url: URL(string: vm.track.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 280, height: 280)
                        .clipShape(Circle())
                        .scaleEffect(vm.isBreathingIn ? 1.1 : 1.0)
                } placeholder: {
                    Circle()
                        .fill(Color.accentSubtle)
                        .frame(width: 280, height: 280)
                        .overlay {
                            ProgressView()
                        }
                }
            }
            .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: vm.isBreathingIn)
            .padding(.top, 32)
            
            // Track Info
            Text(vm.track.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.accentDark)
                .padding(.top, 40)
            
            // Track Description
            Text(vm.track.description)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            // Breathing Toggle Button
            Button(action: {
                vm.toggleBreathing()
                if vm.isBreathingIn {
                    audioService.playSound(named: "meditation-ambient")
                } else {
                    audioService.pauseSound()
                }
            }) {
                Image(systemName: vm.isBreathingIn ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color.accent)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(vm.track.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.isBreathingIn = true
            audioService.playSound()
        }
        .onDisappear {
            audioService.stopSound()
            vm.isBreathingIn = false
        }
        .enableInjection()
    }
}

#Preview {
    NavigationStack {
        MeditationPage(
            track: MeditationTrack(
                id: "",
                title: "",
                duration: 0,
                genre: .ambient,
                imageUrl: "",
                description: ""
            ),
            duration: 300
        )
    }
}
