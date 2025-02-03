//
//  SettingButton.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import Foundation
import SwiftUI

struct SettingButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    var trailingText: String? = nil
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .frame(width: 24)
                Text(title)
                Spacer()
                if let trailingText = trailingText {
                    Text(trailingText)
                        .foregroundColor(.gray)
                }
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(.plain)
    }
}
