//
//  ProfilePage.swift
//  BreatheSpace
//
//  Created by Echo Lumaque on 1/30/25.
//

import SwiftUI

struct ProfilePage: View {
    @State private var vm: ProfilePageViewModel
    
    init() {
        _vm = State(wrappedValue: ProfilePageViewModel())
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text(vm.userName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(vm.email)
                        .foregroundColor(.gray)
                    
                   Text("Age \(vm.userAge), \(vm.userGender)")
                       .foregroundColor(.gray)
                    
                    Button(action: vm.editProfile) {
                        Text("Edit")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .foregroundStyle(.white)
                            .background(Color.accentDark)
                            .clipShape(.capsule)
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            } 
            
            Section {
                ForEach(vm.achievements) { achievement in
                    HStack(spacing: 16) {
                        Image(systemName: achievement.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 29, height: 29)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(achievement.name)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.accentDark)
                            Text(achievement.description)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(achievement.progress)
                            .foregroundStyle(.secondary)
                    }
                }
            } header: {
                Text("Achievements")
            }
            
            Section {
                SettingButton(title: "Account Settings", icon: "person.circle", action: vm.openAccountSettings)
                SettingButton(title: "Subscription", icon: "creditcard", action: vm.openSubscription, trailingText: "Free trial")
                SettingButton(title: "Notifications", icon: "bell", action: vm.openNotifications)
                SettingButton(title: "About", icon: "info.circle", action: vm.openAbout)
            } header: {
                Text("Settings")
            }
            
            Section {
                Button(action: vm.logout) {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(.red)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        }
        .onAppear(perform: vm.onAppear)
        .clipped()
    }
}

#Preview {
    let swiftDataManager = SwiftDataManager()
    
    return ProfilePage()
}
