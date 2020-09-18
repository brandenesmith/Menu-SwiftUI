//
//  LeftView.swift
//  MenuExample
//
//  Created by Branden Smith on 9/17/20.
//

import Foundation
import SwiftUI

struct LeftView: View {
    @ObservedObject private var viewModel: LeftViewModel

    var body: some View {
        VStack {
            Text("Left View")
            Button("Close", action: viewModel.closeButtonTouched)
        }
        .onAppear {
            print("Left View Appeared")
        }
    }

    init(viewModel: LeftViewModel) {
        self.viewModel = viewModel
    }
}
