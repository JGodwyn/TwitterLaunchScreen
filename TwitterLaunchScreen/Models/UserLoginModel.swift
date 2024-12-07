//
//  UserLoginModel.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 06/12/2024.
//

import Foundation
import SwiftUI

enum UserStatus {
    
    case loggedIn
    case loggingIn
    case loggedOut
    case loggingOut
}

struct UserInfo : Identifiable {
    let id = UUID()
    var username : String = ""
    var password : String = ""
}

final class UserClass : ObservableObject {
    
    @Published var userObj : UserInfo = .init(username: "", password: "")
    @Published private(set) var currentState : UserStatus = .loggedOut
    
    func login() {
        // make sure they're not empty
        guard !userObj.username.isEmpty && !userObj.password.isEmpty else { return }
        
        self.currentState = .loggingIn
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            [weak self] in
            withAnimation(.easeOut(duration: 0.2)) {
                self?.currentState = .loggedIn
            }
        }
    }
    
    func logout() {
        self.currentState = .loggingOut
        self.userObj.username = ""
        self.userObj.password = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            [weak self] in
            withAnimation(.easeOut(duration: 0.2)) {
                self?.currentState = .loggedOut
            }
        }
    }
}
