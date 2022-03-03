//
//  Book.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import Foundation
import Files
import Yams

struct Book: Codable {
    let name: String
    let tags: [String]
    
    var tagNames: [String] {
        tags
    }
    
    var output: String {
        if let result = try? YAMLEncoder().encode(self) {
            return result
        } else {
            return ""
        }
    }
    
    static var `default`: Book {
        Book(name: "", tags: [])
    }
}

struct BookInfo: Identifiable {
    let file: File
    let name: String
    let tags: [Tag]
    
    var id: String {
        file.name
    }
    
    init(file: File, settings: UserSettings) {
        let book = Storage.readBook(file: file)
        self.file = file
        self.name = book.name
        self.tags = book.tagNames.map { tagName in
            if let tag = settings.tagLirary.first(where: { $0.name == tagName }) {
                return tag
            } else {
                return settings.addTag(name: tagName, color: TagColor.random)
            }
        }
    }
}
