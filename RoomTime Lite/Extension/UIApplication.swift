//
//  UIApplication.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/28.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
