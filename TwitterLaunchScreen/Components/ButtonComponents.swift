//
//  ButtonComponents.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 06/12/2024.
//

import SwiftUI

struct ButtonComponents: View {
    var body: some View {
        Text("Here are the buttons")
        
        MainButton(label: "Name") {
            
        }
    }
}

#Preview {
    ButtonComponents()
}


struct MainButton : View {
    
    let btnLabel : String
    let btnIcon : String
    let color : Color
    let height : CGFloat
    let fillContainer : Bool
    let btnDisabled : Bool
    let tappedButton : () -> Void
    
    // initialize with label, color, fillContainer, and function
    // default values are set for all of these except function
    init(label: String = "No label",
         icon: String = "none",
         color: Color = .accentColor,
         height: CGFloat = 40,
         fillContainer: Bool = false,
         disabled: Bool = false,
         action: @escaping () -> Void) {
            self.btnLabel = label
            self.color = color
            self.btnIcon = icon
            self.height = height
            self.fillContainer = fillContainer
            self.btnDisabled = disabled
            self.tappedButton = action
    }
    
    var body: some View {
        Button (action: tappedButton) {
            Text(btnLabel)
        }
        .disabled(btnDisabled)
        .opacity(btnDisabled ? 0.5 : 1)
        .buttonStyle(MainButtonStyle(iconName: btnIcon, color: btnDisabled ? .gray : color, height: height, fillContainer: fillContainer))
    }
}
