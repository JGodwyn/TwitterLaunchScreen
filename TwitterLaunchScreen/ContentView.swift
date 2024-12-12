//
//  ContentView.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 12/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    // ignore the second environment variable
    @EnvironmentObject var launchManager : LaunchScreenManager
    @EnvironmentObject var userManager : UserClass
    @EnvironmentObject var postManager : PostClass
    @EnvironmentObject var sheetManager : SheetClass
    @State private var showLogoutAlert : Bool = false
    @State var currentPost : PostStructure = .init(user: .init(), description: "")
    
    var body: some View {
        if userManager.currentState == .loggingOut {
            loggingOut
        } else {
            mainContent
                .addPopUp(sheetManager: sheetManager, actionable: true, btnLabel: "Delete", btnColor: .red) {
                    withAnimation {
                        sheetManager.dismiss()
                        postManager.removePost(item: currentPost)
                    }
                }
            //  .modifier(PopUpModifier(sheetManager: sheetManager, actionable: true, btnLabel: "Delete", btnColor: .red) {
            //                    withAnimation {
            //                        sheetManager.dismiss()
            //                        postManager.removePost(item: currentPost)
            //                    }
            //                })
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LaunchScreenManager())
        .environmentObject(UserClass())
        .environmentObject(PostClass())
        .environmentObject(SheetClass())
}

private extension ContentView {
    
    var mainContent : some View {
        NavigationStack {
            List {
                ForEach(postManager.postManager) { item in
                    PostComponent(content: item, userManager: userManager) {
                        withAnimation {
                            sheetManager.present(obj: .init(iconName: "trash", title: "Are you sure you want to delete this item?", description: item.description))
                        }
                        currentPost = item
                    }
                    .buttonStyle(PlainButtonStyle()) // you need this to tell Swift that the whole row body should not be interactive.
                }
            }
            .navigationTitle(Text(userManager.userObj.username + " Posts"))
            .toolbar {
                HStack {
                    Button("Log Out", role: .destructive) {
                        showLogoutAlert.toggle()
                    }
                    Spacer()
                    Button("New Post") {
                        
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .listStyle(.plain)
            .alert("Log Out", isPresented: $showLogoutAlert) {
                Button("Log Out", role:.destructive) {
                    userManager.logout()
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        launchManager.dismiss()
                    }
                }
            }
        }
    }
    
    
    var loggingOut : some View {
        VStack {
            Text("Logging out ...")
            ProgressView()
        }
    }
}
