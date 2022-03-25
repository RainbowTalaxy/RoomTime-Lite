//
//  RecordDetail.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/25.
//

import Foundation
import Files

class RecordDetail: ObservableObject {
    @Published var title: String
    @Published var authors: [String]
    @Published var tags: [Tag]
    @Published var date: Date
    @Published var content: String
    
    let settings: UserSettings
    let list: RecordList
    let file: File
    
    init(recordInfo: RecordInfo, list: RecordList, settings: UserSettings) {
        let record = Storage.readRecord(file: recordInfo.file)
        self.title = record.title.trimmed()
        self.authors = record.authors
        self.tags = record.tagNames.map { tagName in
            if let tag = settings.tagLirary.first(where: { $0.name == tagName }) {
                return tag
            } else {
                return settings.addTag(name: tagName, color: .random)
            }
        }
        self.date = record.date
        self.content = record.content.trimmed()
        self.settings = settings
        self.file = recordInfo.file
        self.list = list
    }
    
    var authorsText: String {
        authors.joined(separator: ", ")
    }
    
    func store() {
        Storage.store(record: Record(title: title, authors: authors, date: date, tags: tags, content: content), to: file)
    }
    
    func fresh() {
        let record = Storage.readRecord(file: file)
        self.title = record.title.trimmed()
        self.authors = record.authors
        self.tags = record.tagNames.map { tagName in
            if let tag = settings.tagLirary.first(where: { $0.name == tagName }) {
                return tag
            } else {
                return settings.addTag(name: tagName, color: .random)
            }
        }
        self.date = record.date
        self.content = record.content.trimmed()
    }
    
    func hasTag(tag: Tag) -> Bool {
        return tags.contains(tag)
    }
    
    func addTag(tag: Tag) {
        if tags.contains(tag) {
            return
        }
        if !settings.tagLirary.contains(tag) {
            settings.addTag(tag: tag)
        }
        tags.append(tag)
        store()
    }
    
    func removeTag(tag: Tag) {
        if let index = tags.firstIndex(where: { tag == $0 }) {
            tags.remove(at: index)
        }
    }
    
    lazy var keywords: [String] = {
        let docs = list.recordInfos.map { Storage.readRecord(from: $0).content }
        let target = Storage.readRecord(file: file).content
        return KeywordExtraction.getKeywords(target: target, allDocuments: docs)
    }()
}
