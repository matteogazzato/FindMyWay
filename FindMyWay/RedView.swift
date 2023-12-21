//
//  RedView.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 20/12/23.
//

import SwiftUI

struct RedView: View {
    private let navigateBack: () -> Void
    private let navigateToNext: () -> Void
    
    init(
        navigateBack: @escaping () -> Void = {},
        navigateToNext: @escaping () -> Void = {}
    ) {
        self.navigateBack = navigateBack
        self.navigateToNext = navigateToNext
    }
    
    var body: some View {
        ZStack {
            Color.red
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
            }
        }
    }
}

#Preview {
    RedView()
}
