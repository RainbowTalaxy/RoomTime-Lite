//
//  BookDetail.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/3/2.
//

import Foundation
import Files

class BookDetail: ObservableObject {
    @Published var name: String
    @Published var tags: [Tag]
    
    let settings: UserSettings
    let recordList: RecordList
    let file: File
    
    init(bookInfo: BookInfo, recordList: RecordList, settings: UserSettings) {
        self.file = bookInfo.file
        self.name = bookInfo.name
        self.tags = bookInfo.tags
        self.recordList = recordList
        self.settings = settings
    }
    
    var records: [RecordInfo] {
        recordList.recordInfos.filter { record in
            for tag in tags {
                if record.tags.contains(tag) {
                    return true
                }
            }
            return false
        }
    }
    
    func fresh() {
        let book = Storage.readBook(file: file)
        self.name = book.name
        self.tags = book.tagNames.map { tagName in
            if let tag = settings.tagLirary.first(where: { $0.name == tagName }) {
                return tag
            } else {
                return settings.addTag(name: tagName, color: .random)
            }
        }
    }
    
    func update() {
        Storage.store(book: Book(name: name, tags: tags.map { $0.name }), to: file)
    }
}
