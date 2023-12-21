//
//  PinkView.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 21/12/23.
//

import SwiftUI

struct PinkView: View {
    private let navigateBack: () -> Void
    
    init(navigateBack: @escaping () -> Void = {}) {
        self.navigateBack = navigateBack
    }
    
    var body: some View {
        ZStack {
            Color.pink
            Button(
                action: navigateBack,
                label: {
                    Text("Navigate Back")
                }
            )
            .foregroundColor(.white)
        }
    }
}

#Preview {
    PinkView()
}
