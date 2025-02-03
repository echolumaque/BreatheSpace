//
//  MeditationDurationSheet.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/29/25.
//

import SwiftUI

struct MeditationDurationSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(SharedDataStore.self) private var sharedDataStore
    @State var vm: MeditationDurationSheetViewModel
    
    init(track: MeditationTrack) {
        _vm = State(wrappedValue: MeditationDurationSheetViewModel(track: track))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Track Info
                AsyncImage(url: URL(string: vm.track.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(white: 0.9))
                        .frame(width: 120, height: 120)
                        .overlay {
                            ProgressView()
                        }
                }
                
                Text(vm.track.title)
                    .font(.title2)
                    .fontWeight(.bold)
                
                // Duration Picker
                HStack(spacing: 0) {
                    VStack {
                        Picker("Minutes", selection: $vm.minutes) {
                            ForEach(0...59, id: \.self) { minute in
                                Text("\(minute)")
                                    .tag(minute)
                                    .font(.title2)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 120)
                        
                        Text(vm.minutes == 1 ? "minute" : "minutes")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Text(":")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 20)
                    
                    VStack {
                        Picker("Seconds", selection: $vm.seconds) {
                            ForEach(0...59, id: \.self) { second in
                                Text(String(format: "%02d", second))
                                    .tag(second)
                                    .font(.title2)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 120)
                        
                        Text(vm.seconds == 1 ? "second" : "seconds")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                
                Button(action: {
                    let duration = TimeInterval(vm.minutes * 60 + vm.seconds)
                    sharedDataStore.pages.append(.meditation(track: vm.track, duration: duration))
                    dismiss()
                }) {
                    Text("Start Meditation")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentDark)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
            }
            .padding()
            .presentationDetents([.fraction(0.65)])
            .presentationDragIndicator(.visible)
            .navigationTitle("Set Duration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    MeditationDurationSheet(
        track: MeditationTrack(
            id: "",
            title: "",
            duration: 0,
            genre: .ambient,
            imageUrl: "",
            description: ""
        )
    )
    .environment(SharedDataStore())
}
