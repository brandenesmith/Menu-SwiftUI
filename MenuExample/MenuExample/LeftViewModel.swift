//
//  LeftViewModel.swift
//  MenuExample
//
//  Created by Branden Smith on 9/17/20.
//

import Foundation

final class LeftViewModel: ObservableObject {
    init() {}

    func closeButtonTouched() {
        NotificationCenter.default.post(.toggleMenuState)
    }
}

