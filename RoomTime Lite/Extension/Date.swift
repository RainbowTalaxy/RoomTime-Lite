//
//  Date.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/25.
//

import Foundation

extension Date {
    var numeric: String {
        self.formatted(date: .numeric, time: .omitted)
    }
}
