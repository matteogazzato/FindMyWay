//
//  FindMyWayApp.swift
//  FindMyWay
//
//  Created by Matteo Gazzato on 19/12/23.
//

import SwiftUI

@main
struct FindMyWayApp: App {
    
    let navigator =  Navigator(
        store: NavigatorStore(
            initialState: NavigatorState(
                destination: .root,
                navStyle: .popToRoot
            )
        )
    )
    
    var body: some Scene {
        WindowGroup {
            NavigationController(
                rootView: navigator.rootView,
                navigator: navigator
            )
        }
    }
}
