//
//  SheetModels.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 11/12/2024.
//

import Foundation
import SwiftUI

enum SheetStatus {
    
    case na
    // whenever it is set to present, pass some information to the case
    case presented(info : SheetPresentedInfo)
    case dismissed
    
    struct SheetPresentedInfo {
        var iconName : String
        var title : String
        var description : String
    }
    
}


final class SheetClass : ObservableObject {
    
    typealias SheetConfig = SheetStatus.SheetPresentedInfo // this just tells you that Config is of the defined type (just like String, Int, etc)
    
    @Published private(set) var sheetManager : SheetStatus = .na
    
    func present(obj : SheetConfig) {
        guard !isPresented else { return } // make sure the sheet is not presented before you present to avoid presenting twice
        self.sheetManager = .presented(info: obj)
    }
    
    func dismiss() {
        self.sheetManager = .dismissed
    }
    
    var isPresented : Bool {
        // I want to make sure it is set to presented
        // this syntax is even confusing for me
        guard case .presented(_) = self.sheetManager else {
            return false
        }

        return true
    }
    
}
