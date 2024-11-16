//
//  TwitterLaunchScreenApp.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 12/11/2024.
//

import SwiftUI

@main
struct TwitterLaunchScreenApp: App {
    
    // creating a state object I can pass as an environment object.
    @StateObject var launchManager = LaunchScreenManager()
    @StateObject var anotherManager = LaunchScreenManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if launchManager.currentState != .third {
                    // show this screen as far as the current state is not third
                    LaunchScreenView()
                }
            } // I can pass the environment object to the ZStack and they both have access to it
            .environmentObject(launchManager)
            .environmentObject(anotherManager)
        }
    }
}
