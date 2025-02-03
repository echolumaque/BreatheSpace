//
//  SwiftDataManager.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/28/25.
//

import Foundation
import SwiftData

final class SwiftDataManager {
    static let modelContainer: ModelContainer = {
        do {
            let localConfiguration = ModelConfiguration("localConfig",
                                                        isStoredInMemoryOnly: false,
                                                        cloudKitDatabase: .none)
            let modelContainer = try ModelContainer(for: Breathing.self, configurations: localConfiguration)
            
            return modelContainer
        } catch {
            fatalError("Error in initializing model container! \(error.localizedDescription)")
        }
    }()
}
