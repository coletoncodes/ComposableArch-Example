//
//  ContentView.swift
//  ComposableArch-Example
//
//  Created by Coleton Gorecke on 3/30/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ContentViewStore {
    @ObservableState
    struct State: Equatable {
        var counter = 0
    }
    
    enum Action: Equatable {
        case increaseCounter
        case decreaseCounter
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .increaseCounter:
                state.counter += 1
                return .none
            case .decreaseCounter:
                state.counter -= 1
                return .none
            }
        }
    }
}

struct ContentView: View {
    let store: StoreOf<ContentViewStore>
    
    var body: some View {
        VStack {
            Text(store.counter, format: .number)
            
            Button("Increase Counter") {
                store.send(.increaseCounter)
            }
            
            Button("Decrease Counter") {
                store.send(.decreaseCounter)
            }
            
        }
        .padding()
    }
}

//#Preview {
//    ContentView(store: Store(initialState: ContentViewStore.State(), reducer: ()))
//}
