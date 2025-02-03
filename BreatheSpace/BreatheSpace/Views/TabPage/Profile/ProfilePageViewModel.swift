//
//  ProfilePageViewModel.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import SwiftUI

@MainActor
@Observable
class ProfilePageViewModel {
    var achievements: [Achievement] = []
    var email: String = "catherine@gmail.com"
    var userName: String = "John Doe"
    var userAge: Int = 28
    var userGender: String = "Male"
    
    
    init() {
        
    }
    
    func onAppear() {
        if !achievements.isEmpty { return }
        achievements.append(
            contentsOf: [
                Achievement(
                    icon: "medal.fill",
                    name: "Day Streak",
                    description: "Complete 7 days in a row",
                    progress: "2/3"
                ),
                Achievement(
                    icon: "medal.fill",
                    name: "Total Minutes",
                    description: "Logged 700 minutes",
                    progress: "350/1000"
                ),
                Achievement(
                    icon: "medal.fill",
                    name: "Unlocked Level 5",
                    description: "Complete 7 days in a row",
                    progress: "2/3"
                )
            ]
        )
    }
    
    func editProfile() {
        print("Edit profile")
    }
    
    func openAccountSettings() {
        print("Open account settings")
    }
    
    func openSubscription() {
        print("Open subscription")
    }
    
    func openNotifications() {
        print("Open notifications")
    }
    
    func openAbout() {
        print("Open about")
    }
    
    func logout() {
        print("Logout")
    }
}
