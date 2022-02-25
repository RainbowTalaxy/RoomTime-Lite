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
    
    func addTag(name: String, color: TagColor) -> Tag {
        if let tag = tagLirary.first(where: { $0.name == name }) {
            return tag
        }
        let tag = Tag(name: name, color: color)
        tagLirary.append(tag)
        store()
        return tag
    }
    
    func updateTag(tag: Tag, color: TagColor) {
        if let index = tagLirary.firstIndex(where: { $0 == tag }) {
            tagLirary[index] = Tag(name: tag.name, color: color)
            store()
        }
    }
    
    func removeTag(index: Int) {
        tagLirary.remove(at: index)
        store()
    }
    
    func store() {
        Storage.store(userSettings: Settings(authorName: authorName, tagLirary: tagLirary))
    }
    
    func fresh() {
        let settings = Storage.readUserSettings()
        self.authorName = settings.authorName
        self.tagLirary = settings.tagLirary
    }
}
