//
//  ImageLoaderServiceProtocol.swift
//  TestApp
//
//  Created by Akira Rei on 18.01.2026.
//

protocol UserStoryServiceProtocol: AnyObject {
    func getUserSories(page: Int, completion: @escaping ([UserStory]) -> Void)
    func setStory(id: Int, isLiked: Bool)
    func setStory(id: Int, isNew: Bool)
}

final class UserStoryService: UserStoryServiceProtocol {
    private enum Constants {
        static let pageSize: Int = 10
    }
    
    private let dataStorage: DataStorageProtocol

    // MARK: - Init
    init(dataStorage: DataStorageProtocol) {
        self.dataStorage = dataStorage
    }

    // MARK: - UserStoryServiceProtocol
    func getUserSories(page: Int, completion: @escaping ([UserStory]) -> Void) {
        // Fake data with pagination
        let firstId = Constants.pageSize * page
        let lastId = firstId + Constants.pageSize - 1
        let result = (firstId...lastId).map { id in
            var story = UserStory.fake(id: id)
            story.isLiked = dataStorage.getStoryIsLikedState(id: id)
            story.isNew = dataStorage.getStoryIsNewState(id: id)
            return story
        }
		completion(result)
    }

    func setStory(id: Int, isLiked: Bool) {
        dataStorage.setStoryIsLikedState(id: id, isLiked: isLiked)
    }

    func setStory(id: Int, isNew: Bool) {
        dataStorage.setStoryIsNewState(id: id, isNew: isNew)
    }
}
