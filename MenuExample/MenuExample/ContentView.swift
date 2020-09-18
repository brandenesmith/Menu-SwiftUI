//
//  ContentView.swift
//  MenuExample
//
//  Created by Branden Smith on 9/17/20.
//

import SwiftUI
import Menu_SwiftUI

struct ContentView: View {
    var body: some View {
        Menu(
            centerView: CenterView(viewModel: CenterViewModel()),
            leftView: LeftView(viewModel: LeftViewModel())
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
