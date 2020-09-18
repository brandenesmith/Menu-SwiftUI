//
//  File.swift
//  
//
//  Created by Branden Smith on 9/18/20.
//

import Foundation

public extension Notification.Name {
    static let toggleMenuState = Notification.Name("toggleMenuState")
}

public extension Notification {
    static let toggleMenuState = Notification(name: .toggleMenuState)
}
