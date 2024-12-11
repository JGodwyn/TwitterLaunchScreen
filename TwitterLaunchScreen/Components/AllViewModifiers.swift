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
    
    func body(content: Content) -> some View {
        content
            .overlay (alignment: .bottom) {
                if case let .presented(obj) = sheetManager.sheetManager {
                    PostDeleteConfirmation(sheetInfo: obj) {
                        withAnimation {
                            sheetManager.dismiss()
                        }
                    }
                }
            }
            .ignoresSafeArea()
    }
}
