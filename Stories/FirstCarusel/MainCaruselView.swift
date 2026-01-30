//
//  FirstCarusel.swift
//  Stories
//
//  Created by Akira Rei on 18.01.2026.
//

import SwiftUI
import Kingfisher

enum ActualScreen {
    case profileImages
    case fullScreenStory(UserStory)
}

struct MainCaruselView: View {
    @StateObject private var viewModel: ViewModel
    @State var screenState: ActualScreen = .profileImages

    init() {
        self._viewModel = StateObject(wrappedValue: ViewModel())
    }

    var body: some View {
        buildScene()
    }
}

extension MainCaruselView {
    @ViewBuilder
    func buildScene() -> some View {
        switch screenState {
        case .profileImages:
            buildProfiles()
        case .fullScreenStory(let userStory):
            buildFullStory(userStory: userStory)
        }
        
    }
    
    func buildProfiles() -> some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.userStories, id: \.self) { userStory in
                        ProfileImageCell(screenState: $screenState, userStory: userStory)
                            .onAppear {
                                viewModel.listItemAppear(story: userStory)
                            }
                    }
                }
            }
        }
    }
    
    func buildFullStory(userStory: UserStory) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyHStack {
                    ForEach(viewModel.userStories, id: \.self) { userStory in
                        FullScreenCell(screenState: $screenState, userStory: userStory) {
                            viewModel.fullscreenStory(userStory, isLiked: !userStory.isLiked)
                        }
                        .onAppear {
                            viewModel.fullscreenStoryAppear(story: userStory)
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                }
                .scrollTargetLayout()
                .onAppear {
                    proxy.scrollTo(userStory)
                }
            }
        }
        .scrollTargetBehavior(.viewAligned)
    }
}
