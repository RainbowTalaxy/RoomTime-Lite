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
    let file: File
    
    init(recordInfo: RecordInfo, settings: UserSettings) {
        let record = Storage.readRecord(file: recordInfo.file)
        self.title = record.title
        self.authors = record.authors
        self.tags = settings.tagLirary.filter { tag in
            record.tagNames.contains { tag.name == $0 }
        }
        self.date = record.date
        self.content = record.content
        self.settings = settings
        self.file = recordInfo.file
    }
    
    func store() {
        Storage.store(record: Record(title: title, authors: authors, date: date, tags: tags, content: content), to: file)
    }
    
    func fresh() {
        let record = Storage.readRecord(file: file)
        self.title = record.title
        self.authors = record.authors
        self.tags = settings.tagLirary.filter { tag in
            record.tagNames.contains { tag.name == $0 }
        }
        self.date = record.date
        self.content = record.content
    }
}
