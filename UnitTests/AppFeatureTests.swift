//
//  AppFeatureTests.swift
//  UnitTests
//
//  Created by Coleton Gorecke on 3/30/24.
//

@testable import ComposableArch_Example
import ComposableArchitecture
import XCTest

@MainActor
final class AppFeatureTests: XCTestCase {
    private var store: TestStore<AppFeature.State, AppFeature.Action>!
    
    override func setUp() {
        super.setUp()
        
        store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
    }
    
    func testIncrementInFirstTab() async {
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
    
    func testIncrementInSecondTab() async {
        await store.send(\.tab2.incrementButtonTapped) {
            $0.tab2.count = 1
        }
    }
}
