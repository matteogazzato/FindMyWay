//
//  GreenView.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 20/12/23.
//

import SwiftUI

struct GreenView: View {
    
    private let navigateBack: () -> Void
    private let navigateToNext: () -> Void
    private let showScreen: () -> Void
    
    init(
        navigateBack: @escaping () -> Void = {},
        navigateToNext: @escaping () -> Void = {},
        showScreen: @escaping () -> Void = {}
    ) {
        self.navigateBack = navigateBack
        self.navigateToNext = navigateToNext
        self.showScreen = showScreen
    }
    
    var body: some View {
        ZStack {
            Color.green
            VStack(spacing: 20.0) {
                Button(
                    action: navigateBack,
                    label: {
                        Text("Navigate Back")
                    }
                )
                .foregroundColor(.white)
                Button(
                    action: navigateToNext,
                    label: {
                        Text("Navigate To Orange")
                    }
                )
                .foregroundColor(.white)
                Button(
                    action: showScreen,
                    label: {
                        Text("Show Pink")
                    }
                )
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    GreenView()
}
