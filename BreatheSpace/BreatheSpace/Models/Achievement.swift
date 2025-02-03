//
//  Achievement.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import Foundation

struct Achievement: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    let description: String
    let progress: String
}
