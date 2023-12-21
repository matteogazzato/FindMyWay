//
//  Navigator.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 19/12/23.
//

import SwiftUI
import Combine

final class Navigator: ObservableObject {
    @Published private(set) var state: NavigatorState<AnyView>
    private let store: NavigatorStore
    private var bag = Set<AnyCancellable>()
    
    init(store: NavigatorStore) {
        self.store = store
        self.state = store.state.value
        self.store
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] newState in
                self?.state = newState
            }
            .store(in: &bag)
    }
    
    func navigate(to destination: Destination) {
        store.update(destination)
    }
    
    @ViewBuilder
    var rootView: some View {
        ContentView(
            pushGreenView: { [weak self] in self?.navigate(to: .green) },
            presentRedView: { [weak self] in self?.navigate(to: .red) }
        )
    }
}

class NavigatorStore {
    private(set) var state: CurrentValueSubject<NavigatorState<AnyView>, Never>
    
    init(initialState: NavigatorState<AnyView>) {
        self.state = CurrentValueSubject(initialState)
    }
    
    func update(_ destination: Destination) {
        switch destination {
        case .root:
            self.state.send(
                NavigatorState(
                    destination: .root,
                    navStyle: .popToRoot
                )
            )
        case .green:
            let greenView = GreenView(
                navigateBack: { [weak self] in self?.sendPopState() },
                navigateToNext: { [weak self] in self?.update(.orange) },
                showScreen: { [weak self] in self?.update(.pink) }
                
            )
            self.state.send(
                NavigatorState(
                    destination: .green,
                    navStyle: .push(AnyView(greenView))
                )
            )
        case .red:
            let redView = RedView(
                navigateBack: { [weak self] in self?.sendDismissState() },
                navigateToNext: { [weak self] in self?.update(.orange) }
            )
            self.state.send(
                NavigatorState(
                    destination: .red,
                    navStyle: .present(AnyView(redView))
                )
            )
        case .orange:
            let orangeView = OrangeView(
                navigateBack: { [weak self] in self?.sendPopToRootState() }
            )
            self.state.send(
                NavigatorState(
                    destination: .orange,
                    navStyle: .push(AnyView(orangeView))
                )
            )
        case .pink:
            let pinkView = PinkView(
                navigateBack: { [weak self] in self?.sendDismissState() }
            )
            self.state.send(
                NavigatorState(
                    destination: .pink,
                    navStyle: .present(AnyView(pinkView))
                )
            )
        }
    }
    
    func sendPopToRootState() {
        self.state.send(
            NavigatorState(
                destination: .root,
                navStyle: .popToRoot
            )
        )
    }
    
    func sendPopState() {
        self.state.send(
            NavigatorState(
                destination: .root,
                navStyle: .pop
            )
        )
    }
    
    func sendDismissState() {
        self.state.send(
            NavigatorState(
                destination: .root,
                navStyle: .dismiss
            )
        )
    }
}

struct NavigatorState<DestinationContent: View> {
    let destination: Destination
    let navStyle: NavigationStyle<DestinationContent>
}

enum NavigationStyle<DestinationContent: View> {
    case push(DestinationContent)
    case pop
    case dismiss
    case present(DestinationContent)
    case popToRoot
}

enum Destination {
    case root
    case green
    case red
    case orange
    case pink
}
