//
//  UIColor+Color.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import SwiftUI

extension UIColor {
    convenience init(hex: Int) {
        var red: CGFloat = 1
        var green: CGFloat = 1
        var blue: CGFloat = 1
        var alpha: CGFloat = 1
        
        if hex <= 0xFFFFFF {
            red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
            blue = CGFloat((hex & 0x0000FF) >> 0) / 255.0
        } else {
            red = CGFloat((hex & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat((hex & 0x000000FF) >> 0) / 255.0
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    init(hex: Int) {
        self.init(UIColor(hex: hex))
    }
}
