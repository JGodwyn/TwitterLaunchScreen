//
//  LaunchManagerModel.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 14/11/2024.
//

import Foundation

enum LaunchScreenPhases {
    case first // animating up and down
    case second // scaled to fill the full size of the screen
    case third // dismiss the view
}

// now I need to create a publishable  class I can monitor
final class LaunchScreenManager : ObservableObject {
    
    @Published private(set) var currentState : LaunchScreenPhases = .first
    @Published var testString : String = "What manager"
    
    func dismiss() {
        // dismiss the screen
        self.currentState = .second // set to the second phase
        
        // delay one second and set the last phase
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentState = .third
        }
    }
}
