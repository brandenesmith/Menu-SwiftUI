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

    public var body: some View {
        ZStack {

        }
    }

    public init(centerView: CenterView, leftView: LeftView) {
        self.centerView = centerView
        self.leftView = leftView
    }
}
