//
//  PostModel.swift
//  TwitterLaunchScreen
//
//  Created by Gdwn on 11/12/2024.
//

import Foundation
import SwiftUI


struct PostStructure : Identifiable {
    let id = UUID()
    var user : UserInfo
    var description : String
    var liked : Bool = false
    var date : Date = .now
    
    mutating func toggleLiked() {
        self.liked.toggle()
    }
    
    static var examplePost : [PostStructure] = [
        
        .init(user: .init(), description: "This is me trying to see how the post should be like"),
        .init(user: .init(), description: "I am going further to write what I want in this place now", liked: true),
        .init(user: .init(), description: "What happens when we try everything and things still stay the same way, what else should we do?"),
        .init(user: .init(), description: "It was great watching that anime but finishing it had me feel like there's something I missed in the story", liked: true),
        .init(user: .init(), description: "I wasn't ever very good with physics, I think I barely managed every time, but I can see where he is going with this"),
        
    ]
}


final class PostClass : ObservableObject {
    
    @Published private(set) var postManager : [PostStructure] = PostStructure.examplePost
    
    func removePost(item : PostStructure) {
        // checks whether the id is the same and deletes it if true
        // had to force-unwrap cos I am sure there'd be a value
        let mainIndex = self.postManager.firstIndex(where: { $0.id == item.id })!
        self.postManager.remove(at: mainIndex)
    }
    
    func addPost(item: PostStructure) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.postManager.append(item)
                self.postManager.sort{$0.date > $1.date} // sort by date
                // you need to add the sort here so it auto sorts itself when you add a new content
            }
        }
    }
}
