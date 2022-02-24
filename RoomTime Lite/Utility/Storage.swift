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
    static let userSettingsFileName = "Settings.yaml"
    
    static func getFile(named name: String) throws -> File {
        try document.createFileIfNeeded(withName: name, contents: nil)
    }
    
    static func store(userSettings: Settings) {
        do {
            let output = try YAMLEncoder().encode(userSettings)
            try getFile(named: userSettingsFileName).write(output)
        } catch {
            print("[ERROR] Failed to store user settings.")
        }
    }
    
    static func readUserSettings() -> Settings {
        do {
            let content = try getFile(named: userSettingsFileName).readAsString()
            return try YAMLDecoder().decode(Settings.self, from: content)
        } catch {
            print("[ERROR] Failed to read user settings.")
        }
        return Settings.default
    }
}
