//
//  AllViewModifiers.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 11/12/2024.
//

import Foundation
import SwiftUI


struct PopUpModifier : ViewModifier {
    
    @ObservedObject var sheetManager : SheetClass
    var actionable : Bool
    var btnLabel : String = "Change label"
    var btnColor : Color = .accentColor
    var tappedButton : () -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay (alignment: .bottom) {
                ZStack {
                    if case .presented = sheetManager.sheetManager {
                        Color.black.opacity(0.4)
                    }
                }
            }
            .overlay (alignment: .bottom) {
                if case let .presented(obj) = sheetManager.sheetManager {
                    PostDeleteConfirmation(sheetInfo: obj, actionable: actionable, btnLabel: btnLabel, btnColor: btnColor) {
                        withAnimation {
                            sheetManager.dismiss()
                        }
                    } tappedButton : {
                        tappedButton()
                    }
                }
            }
            .ignoresSafeArea()
    }
}


extension View {
    func addPopUp(sheetManager : SheetClass, actionable : Bool, btnLabel : String, btnColor : Color, tappedButton : @escaping () -> Void ) -> some View {
        self.modifier(PopUpModifier(sheetManager: sheetManager, actionable: actionable, btnLabel: btnLabel, btnColor: btnColor, tappedButton: tappedButton))
    }
}
