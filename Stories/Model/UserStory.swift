//
//  UserStory.swift
//  TestApp
//
//  Created by Akira Rei on 18.01.2026.
//

struct UserStory: Equatable, Hashable, Identifiable {
    let id: Int
    let name: String
    let profileImageUrl: String
    let storyImageUrl: String
    var isLiked: Bool
    var isNew: Bool
}
