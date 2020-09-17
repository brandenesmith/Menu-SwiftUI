//
//  Menu.swift
//  
//
//  Created by Branden Smith on 9/17/20.
//

import Foundation
import SwiftUI

struct Menu<CenterView: View, LeftView: View>: View {
    @ObservedObject private var viewModel = MenuViewModel()

    private let centerView: CenterView
    private let leftView: LeftView

    var body: some View {
        ZStack {

        }
    }

    init(centerView: CenterView, leftView: LeftView) {
        self.centerView = centerView
        self.leftView = leftView
    }
}
