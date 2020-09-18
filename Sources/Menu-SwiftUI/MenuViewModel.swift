//
//  MenuViewModel.swift
//  
//
//  Created by Branden Smith on 9/17/20.
//

import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    @Published var menuState: MenuState
    @Published var addLeftView: Bool

    init() {
        menuState = .closed
        addLeftView = false
    }

    func draggingChanged(with value: DragGesture.Value) {
        print("Dragging Changed")
    }

    func draggingEnded(with value: DragGesture.Value) {
        print("Dragging Ended")
    }

    func tapEnded() {
        print("Tap Ended")
    }
}
