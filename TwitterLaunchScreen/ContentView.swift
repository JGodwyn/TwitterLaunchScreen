//
//  ContentView.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 12/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    // ignore the second environment variable
    @EnvironmentObject var launchManager : LaunchScreenManager
    @EnvironmentObject var userManager : UserClass
    @State private var showLogoutAlert : Bool = false
    
    var body: some View {
        if userManager.currentState == .loggingOut {
            loggingOut
        } else {
            mainContent
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LaunchScreenManager())
        .environmentObject(UserClass())
}

private extension ContentView {
    
    var mainContent : some View {
        List {
            Text(userManager.userObj.username)
                .font(.system(size: 20, weight: .bold))
                .listRowSeparator(.hidden)
            
            
            MainButton(label: "Log Out", color: .red) {
                showLogoutAlert.toggle()
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .alert("Log Out", isPresented: $showLogoutAlert) {
            Button("Log Out", role:.destructive) {
                userManager.logout()
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    launchManager.dismiss()
                }
            }
        }
    }
    
    
    var loggingOut : some View {
        VStack {
            Text("Logging out ...")
            ProgressView()
        }
    }
}
