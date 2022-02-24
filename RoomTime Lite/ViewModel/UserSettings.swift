//
//  UserSettings.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var authorName: String
    @Published var tagLirary: [Tag]
    
    init() {
        let settings = Storage.readUserSettings()
        self.authorName = settings.authorName
        self.tagLirary = settings.tagLirary
    }
    
    func addTag(_ tag: Tag) {
        tagLirary.append(tag)
        store()
    }
    
    func removeTag(index: Int) {
        tagLirary.remove(at: index)
        store()
    }
    
    func store() {
        Storage.store(userSettings: Settings(authorName: authorName, tagLirary: tagLirary))
    }
}
