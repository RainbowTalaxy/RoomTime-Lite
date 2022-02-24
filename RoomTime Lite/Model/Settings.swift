//
//  Settings.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import Foundation

struct Settings: Codable {
    let authorName: String
    let tagLirary: [Tag]
    
    static var `default`: Settings {
        Settings(authorName: "", tagLirary: [])
    }
}
