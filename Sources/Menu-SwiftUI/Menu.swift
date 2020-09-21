//
//  Menu.swift
//  
//
//  Created by Branden Smith on 9/17/20.
//

import Foundation
import SwiftUI

public struct Menu<CenterView: View, LeftView: View>: View {
    @ObservedObject private var viewModel = MenuViewModel()

    private let centerView: CenterView
    private let leftView: LeftView

    private var combinedGesture: some Gesture {
        return DragGesture()
            .onChanged(viewModel.draggingChanged(with:))
            .onEnded(viewModel.draggingEnded(with:))
            .simultaneously(
                with: (viewModel.menuState == .open) ? TapGesture()
                    .onEnded(viewModel.tapEnded)
                    : nil
            )
    }

    public var body: some View {
        ZStack {
            GeometryReader { geometry in
                let frame = geometry.frame(in: .local)

                if viewModel.addLeftView {
                    leftView
                        .frame(
                            width: viewModel.leftViewWidth,
                            height: frame.height
                        )
                        .offset(x: viewModel.currentLeftContentLeadingEdge, y: 0)
                        .transition(
                            AnyTransition.asymmetric(
                                insertion: .slide,
                                removal: .offset(x: -viewModel.leftViewWidth, y: 0)
                            )
                        )
                        .onAppear {
                            print("height: \(frame.height), width: \(frame.width)")
                        }
                }
            }
            .edgesIgnoringSafeArea([.top, .bottom])

            centerView
                .offset(x: viewModel.currentCenterContentLeadingEdge, y: 0.0)
                .gesture(combinedGesture)

            GeometryReader { geometry in
                let frame = geometry.frame(in: CoordinateSpace.local)

                Rectangle()
                    .frame(width: viewModel.currentCenterContentLeadingEdge, height: frame.height, alignment: .center)
                    .foregroundColor(
                        Color.black.opacity(
                            Double(viewModel.currentCenterContentLeadingEdge / viewModel.leftViewWidth) * 0.001
                        )
                    )
                    .offset(x: viewModel.currentCenterContentLeadingEdge)
                    .highPriorityGesture(combinedGesture, including: .gesture)
            }
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }

    public init(centerView: CenterView, leftView: LeftView) {
        self.centerView = centerView
        self.leftView = leftView
    }
}
