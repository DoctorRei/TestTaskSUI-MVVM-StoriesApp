//
//  FullScreenCell.swift
//  Stories
//
//  Created by Akira Rei on 18.01.2026.
//

import SwiftUI
import Kingfisher

struct FullScreenCell: View {
    private enum Const {
        static let heartImage: String = "heart.fill"
        static let imageSize: CGFloat = 80
    }
    
    @Binding var screenState: ActualScreen
    let userStory: UserStory
    var completion: () -> Void
    
    var body: some View {
        KFImage(URL(string: userStory.storyImageUrl))
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .init(horizontal: .trailing, vertical: .center), content: {
                likeButton()
            })
            .onTapGesture {
                screenState = .profileImages
            }
    }
    
    func likeButton() -> some View {
        Button {
            completion()
        } label: {
            Image(systemName: Const.heartImage)
                .resizable()
                .frame(width: Const.imageSize, height: Const.imageSize)
                .foregroundStyle(userStory.isLiked ? .red : .black)
        }
    }
}

