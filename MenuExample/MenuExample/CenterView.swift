//
//  CenterView.swift
//  MenuExample
//
//  Created by Branden Smith on 9/17/20.
//

import Foundation
import SwiftUI

struct CenterView: View {
    @ObservedObject private var viewModel: CenterViewModel

    var body: some View {
        VStack {
            Text("Center Content")
            Button("Open Menu", action: viewModel.openButtonTouched)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.pink)
    }

    init(viewModel: CenterViewModel) {
        self.viewModel = viewModel
    }
}
