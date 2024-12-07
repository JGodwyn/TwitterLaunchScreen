//
//  ButtonStyles.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 06/12/2024.
//

import Foundation
import SwiftUI


struct MainButtonStyle : ButtonStyle {
    
    var iconName : String
    var color : Color
    var height : CGFloat
    var fillContainer : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if iconName != "none" {
                // if the name of the icon is not none, show the icon
                // this works with my MainButton component where the icon string is set to none by default
                Image(systemName: iconName)
            }
            
            configuration.label
                .bold()
//                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: height)
        .frame(maxWidth: fillContainer ? .infinity : .none)
        .foregroundColor(.white)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .opacity(configuration.isPressed ? 0.7 : 1) // have the click effect
        .scaleEffect(configuration.isPressed ? 0.5 : 1) // slightly scale down
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed) // animate it
    }
}
