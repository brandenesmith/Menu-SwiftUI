//
//  CenterViewModel.swift
//  MenuExample
//
//  Created by Branden Smith on 9/17/20.
//

import Menu_SwiftUI
import Foundation

final class CenterViewModel: ObservableObject {
    init() {

    }

    func openButtonTouched() {
        NotificationCenter.default.post(.toggleMenuState)
    }
}
