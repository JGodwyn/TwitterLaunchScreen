//
//  ContentView.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 12/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var launchManager : LaunchScreenManager
    @EnvironmentObject var anotherManager : LaunchScreenManager
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text(launchManager.testString)
            Text(anotherManager.testString)
            
            Button("Click me") {
                // logic here
            }
        }
        .padding()
        .onAppear {
            launchManager.testString = "Launch Manager"
            anotherManager.testString = "Yet Another Manager"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    launchManager.dismiss()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LaunchScreenManager())
}
