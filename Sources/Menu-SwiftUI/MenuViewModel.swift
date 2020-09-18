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
    private var updateCurrentCenterLeadingEdgeStream: AnyCancellable?
    private var updateCurrentLeftContentLeadingEdgeStream: AnyCancellable?

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

        updateCurrentCenterLeadingEdgeStream = $menuState
            .filter({ $0 == .closed || $0 == .open })
            .map({ return $0 == .closed ? 0.0 : self.leftViewWidth })
            .assign(to: \.currentCenterContentLeadingEdge, on: self)

        updateCurrentLeftContentLeadingEdgeStream = $currentCenterContentLeadingEdge
            .map({ value in value - self.leftViewWidth })
            .assign(to: \.currentLeftContentLeadingEdge, on: self)
    }

    func draggingChanged(with value: DragGesture.Value) {
        updateStateForDraggingChanged()
        currentCenterContentLeadingEdge = boundedCenterContentLeadingEdge(for: value.translation.width)
    }

    func draggingEnded(with value: DragGesture.Value) {
        updateStateForDraggingEnded()
    }

    func tapEnded() {
        menuState = .closed
    }

    private func updateStateForDraggingChanged() {
        switch menuState {
        case .closed:
            menuState = .isOpening
        case .open:
            menuState = .isClosing
        case .isOpening, .isClosing:
            break
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
            return min(0, value)
        default:
            return currentCenterContentLeadingEdge
        }
    }
}
