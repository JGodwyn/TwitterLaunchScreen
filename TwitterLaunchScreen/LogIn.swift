//
//  LogIn.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 06/12/2024.
//

import SwiftUI

struct LogIn: View {
    
    // this will hold the information for the time being
    @State private var username : String = ""
    @State private var password : String = ""
    @EnvironmentObject var userManager : UserClass
    @FocusState private var inputFocused : Bool
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 24) {
                Text("Login into your account")
                    .font(.system(size: 32, weight: .bold))
                
                VStack (alignment: .leading) {
                    Text("What's your username?")
                    TextField("Your username", text: $userManager.userObj.username)
                }
                
                VStack (alignment: .leading) {
                    Text("What's your password?")
                    SecureField("Your password", text: $userManager.userObj.password)
                }
                
                if userManager.currentState == .loggingIn {
                    VStack {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                }
                
                MainButton(label: "Login", fillContainer: true, disabled: userManager.currentState == .loggingIn ? true : false) {
                    inputFocused = false
                    userManager.login()
                }
            }
            .focused($inputFocused)
            .frame(maxWidth: .infinity, alignment: .leading)
            .textFieldStyle(.roundedBorder)
            .submitLabel(.go)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button ("Done") {
                        inputFocused = false
                    }
                }
            }
            .onSubmit(of: .text) {
                inputFocused = false
                userManager.login()
            }
        }
        .padding(24)
        .background(.white)
    }
}

#Preview {
    LogIn()
        .environmentObject(UserClass())
}
