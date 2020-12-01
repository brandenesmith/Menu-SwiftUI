//
//  Notification+Menu.swift
//  
//
//  Created by Branden Smith on 9/18/20.
//

import Foundation

public extension Notification.Name {
    static let toggleMenuState = Notification.Name("toggleMenuState")
    static let menuAnimationFinished = Notification.Name("menuAnimationFinished")
}

public extension Notification {
    static let toggleMenuState = Notification(name: .toggleMenuState)
    static let menuAnimationFinished = Notification(name: .menuAnimationFinished)
}
