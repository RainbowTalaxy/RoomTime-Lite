//
//  Record.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/24.
//

import Foundation
import Markdown
import Yams
import Files

fileprivate let resolver = Markdown.Resolver(
    splitRules: [
        SpaceConvertRule(priority: 0),
        FrontMatterSplitRule(priority: 1),
    ], mapRules: [
        FrontMatterMapRule(priority: 0),
        ComsumeRule(priority: 1),
    ])

struct Record {
    let title: String
    let authors: [String]
    let date: Date
    let tagNames: [String]
    let content: String
    
    init(raw: String) {
        var title = ""
        var authors: [String] = []
        var date = Date()
        var tagNames: [String] = []
        var content = ""
        
        for element in resolver.render(text: raw) {
            switch element {
            case let fm as FrontMatterElement:
                title = fm.properties["title"] as? String ?? ""
                authors = fm.properties["authors"] as? [String] ?? []
                date = fm.properties["date"] as? Date ?? Date()
                tagNames = fm.properties["tags"] as? [String] ?? []
            case let raw as RawElement:
                content = raw.text
            default:
                break
            }
        }
        
        self.title = title
        self.authors = authors
        self.date = date
        self.tagNames = tagNames
        self.content = content
    }
    
    init(title: String, authors: [String], date: Date, tags: [Tag], content: String) {
        self.title = title
        self.authors = authors
        self.date = date
        self.tagNames = tags.map { $0.name }
        self.content = content
    }
    
    var format: String {
        let fm: [String: Any] = [
            "authors": authors,
            "date": date,
            "tags": tagNames,
        ]
        let yaml = (try? Yams.dump(object: fm)) ?? ""
        return "\(yaml)\n\(content)"
    }
}

struct RecordInfo: Identifiable {
    let file: File
    let title: String
    let date: Date
    let tags: [Tag]
    
    var id: String {
        file.name
    }
    
    init(file: File, settings: UserSettings) {
        let record = Storage.readRecord(file: file)
        
        self.file = file
        self.title = record.title
        self.date = record.date
        self.tags = record.tagNames.map { tagName in
            if let tag = settings.tagLirary.first(where: { $0.name == tagName }) {
                return tag
            } else {
                return settings.addTag(name: tagName, color: TagColor.random)
            }
        }
    }
}
