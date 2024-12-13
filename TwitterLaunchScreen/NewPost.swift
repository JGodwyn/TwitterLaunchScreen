//
//  NewPost.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 12/12/2024.
//

import SwiftUI

struct NewPost: View {
    
    @Environment (\.dismiss) private var dismissAllSheets
    @EnvironmentObject var postManager : PostClass
    @ObservedObject var userManager : UserClass
    @State private var sentenceText : String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Spacer()
                    Button("Cancel") {
                        dismissAllSheets()
                    }
                }
                
                Text("Write a new post")
                    .font(.system(size: 28, weight: .bold))
                
                ZStack (alignment: .topLeading) {
                    TextEditor(text: $sentenceText)
                        .frame(height: 256)
                        .padding(12)
                    //                        .overlay {
                    //                            RoundedRectangle(cornerRadius: 12)
                    //                                .stroke(.gray, lineWidth: 0.2)
                    //                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    if sentenceText.isEmpty {
                        Text("Start typing")
                            .foregroundStyle(.gray.opacity(0.75))
                            .padding(.leading, 16)
                            .padding(.top, 20)
                    }
                }
                
                MainButton(label: "Post", fillContainer: true, disabled: sentenceText.isEmpty) {
                        postManager.addPost(item: .init(user: userManager.userObj, description: sentenceText))
                    dismissAllSheets()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    NewPost(userManager: .init())
        .environmentObject(UserClass())
        .environmentObject(PostClass())
}
