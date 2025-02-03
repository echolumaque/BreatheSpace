//
//  BreatheSpaceTab.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

enum BreatheSpaceTab: String, CaseIterable, Identifiable {
    case home = "Home"
    case music = "Music"
    case profile = "Profile"
    
    var id: Self { self }
    
    var icon: String {
        switch self {
        case .home:
            "house.fill"
        case .music:
            "music.note"
        case .profile:
            "person.fill"
        }
    }
}
