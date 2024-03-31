//
//  ComposableArch_ExampleApp.swift
//  ComposableArch-Example
//
//  Created by Coleton Gorecke on 3/30/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct ComposableArch_ExampleApp: App {
    static let counterViewStore = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: ComposableArch_ExampleApp.counterViewStore)
        }
    }
}
