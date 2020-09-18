//
//  MenuViewModel.swift
//  
//
//  Created by Branden Smith on 9/17/20.
//

import Combine
import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    @Published var menuState: MenuState
    @Published var addLeftView: Bool
    @Published private(set) var currentCenterContentLeadingEdge: CGFloat = 0.0
    @Published private(set) var currentLeftContentLeadingEdge: CGFloat = 0.0

    private let leftViewWidth: CGFloat = UIScreen.main.bounds.width * 0.8

    private var addLeftViewStream: AnyCancellable?
    private var updateLeadingEdgesStream: AnyCancellable?

    private var isOneQuarterOpen: Bool {
        return currentCenterContentLeadingEdge > leftViewWidth / 4.0
    }

    private var isOneQuarterClosed: Bool {
        return currentCenterContentLeadingEdge < leftViewWidth * (3 / 4.0)
    }

    init() {
        menuState = .closed
        addLeftView = false

        addLeftViewStream = $menuState
            .map({ $0 != .closed })
            .assign(to: \.addLeftView, on: self)

        updateLeadingEdgesStream = $menuState
            .filter({ $0 == .closed || $0 == .open })
            .map({ return $0 == .closed ? 0.0 : self.leftViewWidth })
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }

                self.currentCenterContentLeadingEdge = value
                self.currentLeftContentLeadingEdge = value - self.leftViewWidth
            })
    }

    func draggingChanged(with value: DragGesture.Value) {
        updateStateForDraggingChanged(given: value.translation.width)

        withAnimation {
            currentCenterContentLeadingEdge = boundedCenterContentLeadingEdge(for: value.translation.width)
        }
    }

    func draggingEnded(with value: DragGesture.Value) {
        updateStateForDraggingEnded()
    }

    func tapEnded() {
        withAnimation { menuState = .closed }
    }

    private func updateStateForDraggingChanged(given value: CGFloat) {
        let draggingToOpen = value >= 0.0

        switch menuState {
        case .closed:
            if draggingToOpen {
                menuState = .isOpening
            }
        case .open:
            if !draggingToOpen {
                menuState = .isClosing
            }
        case .isOpening:
            if !draggingToOpen {
                menuState = .closed
            }
        case .isClosing:
            if draggingToOpen {
                menuState = .open
            }
        }
    }

    private func updateStateForDraggingEnded() {
        switch menuState {
        case .isOpening:
            menuState = (isOneQuarterOpen) ? .open : .closed
        case .isClosing:
            menuState = (isOneQuarterClosed) ? .closed : .open
        case .open, .closed:
            break
        }
    }

    private func boundedCenterContentLeadingEdge(for value: CGFloat) -> CGFloat {
        switch menuState {
        case .isOpening:
            return max(value, leftViewWidth)
        case .isClosing:
            return min(0, leftViewWidth - value)
        default:
            return currentCenterContentLeadingEdge
        }
    }
}
