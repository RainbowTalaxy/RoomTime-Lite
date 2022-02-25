//
//  Tag.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import Foundation
import SwiftUI
import RoomTime

struct Tag: Codable, Identifiable, Hashable {
    let name: String
    let color: TagColor
    
    var id: String {
        name
    }
}

enum TagColor: String, Codable, Identifiable {
    case red, orange, yellow, green, cyan, sky, blue, purple, pink,
         gray, lightgray
    
    static let all = [
        red, orange, yellow, green, cyan, sky, blue, purple, pink,
             gray, lightgray
    ]
    
    static var random = all.randomElement() ?? .red
    
    var id: String {
        self.rawValue
    }
    
    var value: Color {
        switch self {
        case .red:
            return Color(hex: 0xF5BCBC)
        case .orange:
            return Color(hex: 0xFDD0B2)
        case .yellow:
            return Color(hex: 0xFCE8B2)
        case .green:
            return Color(hex: 0xD3F2B2)
        case .cyan:
            return Color(hex: 0xC6F3E9)
        case .sky:
            return Color(hex: 0xC1EDFF)
        case .blue:
            return Color(hex: 0xB2DEFF)
        case .purple:
            return Color(hex: 0xCFC2FF)
        case .pink:
            return Color(hex: 0xE9BCF5)
        case .gray:
            return Color(hex: 0xD3D4D6)
        case .lightgray:
            return Color(hex: 0xE9E9E9)
        }
    }
}
