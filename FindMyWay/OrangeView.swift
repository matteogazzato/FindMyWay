//
//  OrangeView.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 21/12/23.
//

import SwiftUI

struct OrangeView: View {
    
    private let navigateBack: () -> Void
    
    init(navigateBack: @escaping () -> Void = {}) {
        self.navigateBack = navigateBack
    }
    
    var body: some View {
        ZStack {
            Color.orange
            Button(
                action: navigateBack,
                label: {
                    Text("Navigate Back To Root")
                }
            )
            .foregroundColor(.white)
        }
    }
}

#Preview {
    OrangeView()
}
