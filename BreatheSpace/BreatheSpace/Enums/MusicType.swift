enum MusicType: String, Identifiable, CaseIterable, Codable, Hashable, Equatable {
    case focus = "Focus"
    case sleep = "Sleep" 
    case meditation = "Meditation"
    case stress = "Stress"
    case anxiety = "Anxiety"
    case relaxation = "Relaxation"
    case nature = "Nature"
    case ambient = "Ambient"
    case breathwork = "Breathwork"
    case healing = "Healing"
    
    var id: String { rawValue }
}