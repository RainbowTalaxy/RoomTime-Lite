//
//  Storage.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import Foundation
import Files
import Yams

class Storage {
    static let document = Folder.documents!
    
    static let recordFileExtension = "md"
    static let recordsDirectoryName = "Records"
    
    static let bookFileExtension = "yaml"
    static let booksDirectoryName = "Books"
    
    static let userSettingsFileName = "Settings.yaml"
    
    static var newRecordFileName: String {
        "\(Date())+\(UUID()).\(recordFileExtension)"
    }
    
    static var newBookFileName: String {
        "\(Date())+\(UUID()).\(bookFileExtension)"
    }
    
    static func getFile(named name: String) throws -> File {
        try document.createFileIfNeeded(withName: name, contents: nil)
    }
    
    static func getFolder(named name: String) throws -> Folder {
        try document.createSubfolderIfNeeded(withName: name)
    }
    
    // MARK: User Setting
    
    static func store(userSettings: Settings) {
        do {
            let output = try YAMLEncoder().encode(userSettings)
            try getFile(named: userSettingsFileName).write(output)
        } catch {
            print("[ERROR] Failed to store User Settings.")
        }
    }
    
    static func readUserSettings() -> Settings {
        do {
            let content = try getFile(named: userSettingsFileName).readAsString()
            if content.trimmed().isEmpty {
                let settings = Settings.default
                store(userSettings: settings)
                return settings
            }
            return try YAMLDecoder().decode(Settings.self, from: content)
        } catch {
            print("[ERROR] Failed to read User Settings.")
        }
        return Settings.default
    }
    
    // MARK: Record
    
    static func getRecordsInfo(settings: UserSettings) -> [RecordInfo] {
        if let files = (try? getFolder(named: recordsDirectoryName).files) {
            return files.map { RecordInfo(file: $0, settings: settings) }
        }
        return []
    }
    
    static func readRecord(from info: RecordInfo) -> Record {
        readRecord(file: info.file)
    }
    
    static func readRecord(file: File) -> Record {
        do {
            let content = try file.readAsString()
            return Record(raw: content)
        } catch {
            print("[ERROR] Failed to read Record from \(file).")
        }
        return Record(raw: "")
    }
    
    static func store(record: Record, to file: File) {
        do {
            try file.write(record.format)
        } catch {
            print("[ERROR] Failed to store Record to \(file).")
        }
    }
    
    static func createRecord(settings: UserSettings) {
        do {
            let file = try getFolder(named: recordsDirectoryName).createFile(named: newRecordFileName)
            store(record: Record(title: "", authors: [settings.authorName], date: Date(), tags: [], content: ""), to: file)
        } catch {
            print("[ERROR] Failed to create Record.")
        }
    }
    
    static func deleteRecord(record: RecordInfo) {
        do {
            try record.file.delete()
        } catch {
            print("[ERROR] Failed to delete Record.")
        }
    }
    
    // MARK: Book
    
    static func getBooksInfo(settings: UserSettings) -> [BookInfo] {
        if let files = (try? getFolder(named: booksDirectoryName).files) {
            return files.map { BookInfo(file: $0, settings: settings) }
        }
        return []
    }
    
    static func readBook(file: File) -> Book {
        do {
            let content = try file.readAsString()
            if content.trimmed().isEmpty {
                let book = Book.default
                store(book: book, to: file)
                return book
            }
            return try YAMLDecoder().decode(Book.self, from: content)
        } catch {
            print("[ERROR] Failed to read Book from \(file).")
        }
        return Book.default
    }
    
    static func store(book: Book, to file: File) {
        do {
            try file.write(book.output)
        } catch {
            print("[ERROR] Failed to store Book to \(file).")
        }
    }
    
    static func createBook(book: Book) {
        do {
            let file = try getFolder(named: booksDirectoryName).createFile(named: newBookFileName)
            store(book: book, to: file)
        } catch {
            print("[ERROR] Failed to create Book.")
        }
    }
    
    static func createBook(settings: UserSettings) -> BookInfo? {
        do {
            let file = try getFolder(named: booksDirectoryName).createFile(named: newBookFileName)
            return BookInfo(file: file, settings: settings)
        } catch {
            print("[ERROR] Failed to create Book.")
        }
        return nil
    }
    
    static func deleteBook(book: BookInfo) {
        do {
            try book.file.delete()
        } catch {
            print("[ERROR] Failed to delete Book.")
        }
    }
}
