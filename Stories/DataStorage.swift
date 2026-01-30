//
//  DataStorage.swift
//  TestApp
//
//  Created by Akira Rei on 18.01.2026.
//

import Foundation

protocol DataStorageProtocol: AnyObject {
    func getStoryIsLikedState(id: Int) -> Bool
    func getStoryIsNewState(id: Int) -> Bool
    func setStoryIsLikedState(id: Int, isLiked: Bool)
    func setStoryIsNewState(id: Int, isNew: Bool)
}

final class DataStorage: DataStorageProtocol {
    func getStoryIsLikedState(id: Int) -> Bool {
        UserDefaults.standard.bool(forKey: DataKey.isLiked.keyString(with: id))
    }

    func getStoryIsNewState(id: Int) -> Bool {
        if UserDefaults.standard.value(forKey: DataKey.isNew.keyString(with: id)) != nil {
            return UserDefaults.standard.bool(forKey: DataKey.isNew.keyString(with: id))
        } else {
            UserDefaults.standard.set(true, forKey: DataKey.isNew.keyString(with: id))
            return true
        }
    }

    func setStoryIsLikedState(id: Int, isLiked: Bool) {
        UserDefaults.standard.set(isLiked, forKey: DataKey.isLiked.keyString(with: id))
    }

    func setStoryIsNewState(id: Int, isNew: Bool) {
        UserDefaults.standard.set(isNew, forKey: DataKey.isNew.keyString(with: id))
    }
}

private enum DataKey: String {
    case isLiked = "isLikedKey"
    case isNew = "isNewKey"

    func keyString(with id: Int) -> String {
        "\(self.rawValue)_\(id)"
    }
}
