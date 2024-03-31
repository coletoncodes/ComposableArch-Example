//
//  CounterFeatureTests.swift
//  UnitTests
//
//  Created by Coleton Gorecke on 3/30/24.
//

@testable import ComposableArch_Example
import ComposableArchitecture
import XCTest

@MainActor
final class CounterFeatureTests: XCTestCase {
    private var store: TestStore<CounterFeature.State, CounterFeature.Action>!
    private var testClock: TestClock<Duration>!
    
    override func setUp() {
        super.setUp()
        
        self.testClock = TestClock()
        
        store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = self.testClock
        }
    }
    
    /*
     Tip:
     Prefer to use “absolute” mutations, such as count = 1, rather than “relative” mutations, such as count += 1.
     The former is a stronger assertion that proves you know the exact state your feature is in rather than merely
     what transformation was applied to your state.
     
     */
    func testCounter() async {
        // Increment once
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        // Decrement once
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
    
    func testTimer() async {
        // Tap timer
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        
        await testClock.advance(by: .seconds(1))
        
        // When this action is triggered by reducer
        // it publishes the action, assert value
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        
        // Tap timer again
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        
        await store.receive(\.factResponse, timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is a good number"
        }
    }
}
