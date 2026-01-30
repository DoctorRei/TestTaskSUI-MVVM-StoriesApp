//
//  UserStoryMock.swift
//  TestApp
//
//  Created by Akira Rei on 18.01.2026.
//

extension UserStory {
    static func fake(id: Int) -> UserStory {
        UserStory(
            id: id,
            name: "User_\(id)",
            profileImageUrl: "https://i.pravatar.cc/300?u=\(id)",
            storyImageUrl: "https://i.pravatar.cc/1284?u=\(id)",
            isLiked: false,
            isNew: true
        )
    }
}
