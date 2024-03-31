//
//  AppView.swift
//  ComposableArch-Example
//
//  Created by Coleton Gorecke on 3/30/24.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = ContactsFeature.State()
    }
    
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(ContactsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        
        Scope(state: \.tab2, action: \.tab2) {
            ContactsFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}

import SwiftUI

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Text("Counter")
                }
            
            ContactsView(
                store: store.scope(state: \.tab2, action: \.tab2)
            )
            .tabItem {
                Text("Contacts")
            }
        }
    }
}

#Preview {
    AppView(
        store: Store(initialState: AppFeature.State()) {
            AppFeature()
        }
    )
}
