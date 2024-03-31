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
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: ComposableArch_ExampleApp.store)
        }
    }
}
