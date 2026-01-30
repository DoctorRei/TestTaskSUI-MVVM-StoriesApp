//
//  CaruselCell.swift
//  Stories
//
//  Created by Akira Rei on 18.01.2026.
//

import SwiftUI
import Kingfisher

struct ProfileImageCell: View {
    private enum Const {
        static let imageSize: CGFloat = 120
        static let lineWidth: CGFloat = 2
    }
    
    @Binding var screenState: ActualScreen
    var userStory: UserStory
    
    var body: some View {
        Button {
            screenState = .fullScreenStory(userStory)
        } label: {
            KFImage(URL(string: userStory.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: Const.imageSize, height: Const.imageSize)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(userStory.isNew
                                ? Color.blue
                                : Color.black,
                                lineWidth: Const.lineWidth)
                )
        }
    }
    
}

