//
//  Color+Extension.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let accent = Color(hex: 0x8B5CF6)
    static let accentLight = Color(hex: 0xA78BFA)
    static let accentDark = Color(hex: 0x7C3AED)
    static let accentSubtle = Color(hex: 0xEDE9FE)
}
