//
//  File.swift
//  
//
//  Created by Branden Smith on 9/18/20.
//

import Foundation

public extension Notification.Name {
    static let setMenuState = Notification.Name("setMenuState")
}

public extension Notification {
    static func setMenuState(to open: Bool) -> Notification {
        return Notification(name: .setMenuState, object: open, userInfo: nil)
    }
}
