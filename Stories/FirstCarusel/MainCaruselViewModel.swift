//
//  FirstCaruselViewModel.swift
//  Stories
//
//  Created by Akira Rei on 18.01.2026.
//

import SwiftUI

extension MainCaruselView {
    final class ViewModel: ObservableObject {
        @Published var userStories: [UserStory] = []
        @Published var activeStory: UserStory?
        private let userStoryService = UserStoryService(dataStorage: DataStorage())
        private var currentPage = -1
        private var canLoadMore = true
        
        // MARK: - Init
        init() {
            loadData()
        }
        
        // MARK: - Public
        func listItemAppear(story: UserStory) {
            loadDataIfNeeded(story: story)
        }
        
        func fullscreenStoryAppear(story: UserStory) {
            loadDataIfNeeded(story: story)
            
            userStoryService.setStory(id: story.id, isNew: false)
            guard let index = userStories.firstIndex(of: story) else { return }
            userStories[index].isNew = false
        }
        
        func fullscreenStory(_ story: UserStory, isLiked: Bool) {
            userStoryService.setStory(id: story.id, isLiked: isLiked)
            guard let index = userStories.firstIndex(of: story) else { return }
            userStories[index].isLiked = isLiked
        }
        
        // MARK: - Private
        private func loadDataIfNeeded(story: UserStory) {
            let needLoadMore = userStories.isEmpty || userStories.last == story
            if needLoadMore {
                loadData()
            }
        }
        
        private func loadData() {
            guard canLoadMore else { return }
            canLoadMore = false
            let page = currentPage + 1

            userStoryService.getUserSories(page: page) { [weak self] userStories in
                guard let self else { return }
                self.userStories.append(contentsOf: userStories)
                self.currentPage = page
                self.canLoadMore = true
            }
        }
    }
}
