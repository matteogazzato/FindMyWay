//
//  ContentView.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 19/12/23.
//

import SwiftUI

struct ContentView: View {
    
    private let pushGreenView: () -> Void
    private let presentRedView: () -> Void
    
    init(
        pushGreenView: @escaping () -> Void = {},
        presentRedView: @escaping () -> Void = {}
    ) {
        self.pushGreenView = pushGreenView
        self.presentRedView = presentRedView
    }
    
    
    var body: some View {
        VStack(spacing: 20.0) {
            Text("Hello, world!")
            Button(
                action: pushGreenView,
                label: {
                Text("Push Green View")
            })
            Button(
                action: presentRedView,
                label: {
                Text("Present Red View")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
