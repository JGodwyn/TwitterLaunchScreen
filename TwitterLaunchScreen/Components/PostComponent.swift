//
//  PostComponent.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 07/12/2024.
//

import SwiftUI

struct PostComponent: View {
    
    @State var content : PostStructure
    @ObservedObject var userManager : UserClass
    let tappedDelete : () -> Void
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person")
                    .symbolVariant(.circle.fill)
                    .font(.system(size: 24))
                Text(userManager.userObj.username)
                    .font(.system(size: 18))
                    .bold()
            }
            
            Text(content.description)
            
            HStack (spacing: 16) {
                Button {
                    withAnimation(.spring) {
                        content.toggleLiked()
                    }
                } label : {
                    Image(systemName: "heart")
                        .foregroundColor(content.liked ? .red : .blue)
                        .symbolVariant(content.liked ? .fill : .none)
                }
                
                Button {
                    withAnimation(.spring) {
                        tappedDelete()
                    }
                } label : {
                    Image(systemName: "trash")
                }
                
                Spacer()
                Text(content.date, format: Date.FormatStyle(time: .shortened))
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(4)
        .background(.white)
    }
}

#Preview {
    PostComponent(content: .init(user: .init(), description: ""), userManager: .init()){}
        .environmentObject(PostClass())
        .environmentObject(UserClass())
        .environmentObject(SheetClass())
}
