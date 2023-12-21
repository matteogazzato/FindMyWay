//
//  NavigationController.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 19/12/23.
//

import SwiftUI
import Combine

struct NavigationController<RootView: View>: UIViewControllerRepresentable {
    
    @StateObject private var navigator: Navigator
    private let navigationController: UINavigationController
    private let rootView: RootView
    private var bag = Set<AnyCancellable>()
    
    init(rootView: RootView, navigator: Navigator) {
        self._navigator = StateObject(wrappedValue: navigator)
        self.rootView = rootView
        let hostingVc = UIHostingController(rootView: self.rootView)
        self.navigationController = UINavigationController(rootViewController: hostingVc)
        self.navigationController.navigationBar.isHidden = true
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        handleState(navigator.state)
    }
    
    private func handleState(_ newState: NavigatorState<AnyView>) {
        switch newState.navStyle {
        case .push(let destinationContent):
            navigationController.pushViewController(
                UIHostingController(rootView: destinationContent),
                animated: true
            )
        case .pop:
            navigationController.popViewController(animated: true)
        case .present(let destinationContent):
            navigationController.present(
                UINavigationController(
                    rootViewController: UIHostingController(
                        rootView: destinationContent
                    )
                ),
                animated: true
            )
        case .popToRoot:
            navigationController.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        case .dismiss:
            navigationController.dismiss(animated: true)
        }
    }
}
