//
//  PostDeleteConfirmation.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 11/12/2024.
//

import SwiftUI

struct PostDeleteConfirmation: View {
    
    let sheetInfo : SheetClass.SheetConfig
    var actionable : Bool = false
    var btnLabel : String = "Edit btnLabel"
    var btnColor : Color = .accentColor
    let tappedClose : () -> Void
    let tappedButton : () -> Void
    
    var body: some View {
        //        ZStack {
        //            Color.black.opacity(0.2)
        //        }
        //        .ignoresSafeArea()
        //        .overlay (alignment: .bottom) {
        //            popUpDesign
        //        }
        
        popUpDesign
    }
}

#Preview {
    PostDeleteConfirmation(sheetInfo: .init(iconName: "trash", title: "Delete this post?", description: "Are you sure you want to delete this post?")) {
        
    } tappedButton: {
        //
    }
        .environmentObject(SheetClass())
}


extension PostDeleteConfirmation {
    
    var popUpDesign : some View {
        VStack(spacing: 8) {
            Image(systemName: sheetInfo.iconName)
                .symbolVariant(.circle.fill)
                .font(.system(size: 48))
                .foregroundColor(.red)
            
            Text(sheetInfo.title)
                .font(.system(size: 20, weight: .bold))
            Image(systemName: "quote.opening")
            Text(sheetInfo.description)
                .foregroundStyle(.gray)
            
            if actionable {
                MainButton(label: btnLabel, color: btnColor, fillContainer: true) {
                    tappedButton()
                }
                .padding(.top, 16)
            }
        }
        .multilineTextAlignment(.center)
        .padding()
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity)
        .background(unEvenEdges)
        .transition(.move(edge: .bottom))
        .overlay (alignment: .topTrailing) {
            Button {
                tappedClose()
            } label : {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
                    .padding()
                    .background(.gray.opacity(0.15))
                    .clipShape(Circle())
                    .offset(x: -16, y: 16)
            }
        }
    }
    
    var unEvenEdges: some View {
        UnevenRoundedRectangle(cornerRadii: .init(
            topLeading: 16,
            bottomLeading: 0.0,
            bottomTrailing: 0.0,
            topTrailing: 16),
                               style: .continuous)
        .fill(.white)
        
    }
}
