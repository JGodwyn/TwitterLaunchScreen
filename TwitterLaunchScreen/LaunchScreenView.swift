//
//  LaunchScreenView.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 12/11/2024.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var launchManager : LaunchScreenManager
    @State private var firstPhaseIsAnimating : Bool = false
    @State private var secondPhaseIsAnimating : Bool = false
    
    // create a timer that publishes an event every 0.65 seconds on the main thread
    // using the common runloop mode.
    // autoconnect() so it works immediately it is connected to a receiver
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            launchBackground
            twitterLogo
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.1) {
                switch launchManager.currentState {
                case .second :
                    withAnimation (.easeOut(duration: 2)) {
                        secondPhaseIsAnimating = true
                    }
                default:
                    break
                }
                
            }
        }
        .onReceive(timer) { input in
            // when yuu receive an input, do the following…
                switch launchManager.currentState {
                case .first:
                    withAnimation(.spring) {
                        firstPhaseIsAnimating.toggle()
                    }
//                case .second:
//                    withAnimation(.easeOut(duration: 2)) {
//                        secondPhaseIsAnimating.toggle()
//                    }
                default:
                    break
            }
        }
    }
}

#Preview {
    LaunchScreenView()
        .environmentObject(LaunchScreenManager())
}

private extension LaunchScreenView {
    
    var launchBackground : some View {
        Color("launch-screen-background")
            .ignoresSafeArea()
    }
    
    var twitterLogo : some View {
        Image("Twitterlogo")
            .scaleEffect(firstPhaseIsAnimating ? 0.6 : 1)
            .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
    }
}
