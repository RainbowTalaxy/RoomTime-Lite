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
    static let userSettingsFileName = "Settings.yaml"
    static let recordsDirectoryName = "Records"
    
    static func getFile(named name: String) throws -> File {
        try document.createFileIfNeeded(withName: name, contents: nil)
    }
    
    static func getFolder(named name: String) throws -> Folder {
        try document.createSubfolderIfNeeded(withName: name)
    }
    
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
            return try YAMLDecoder().decode(Settings.self, from: content)
        } catch {
            print("[ERROR] Failed to read User Settings.")
        }
        return Settings.default
    }
    
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
    
    static func createRecord(settings: UserSettings) -> RecordInfo? {
        do {
            let file = try getFolder(named: recordsDirectoryName).createFile(named: "\(Date()).\(recordFileExtension)")
            return RecordInfo(file: file, settings: settings)
        } catch {
            print("[ERROR] Failed to create Record.")
        }
        return nil
    }
}
