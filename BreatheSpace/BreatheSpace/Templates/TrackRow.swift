//
//  TrackRow.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/29/25.
//

import Inject
import SwiftUI

struct TrackRow: View {
    @ObserveInjection private var inject
    let track: MeditationTrack
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: track.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(track.title)
                    .font(.headline)
                
                Text(track.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Text("\(track.duration / 60)m")
                .foregroundStyle(.secondary)
        }
        .enableInjection()
    }
}
