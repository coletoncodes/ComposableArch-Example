//
//  ContactsFeatureTests.swift
//  UnitTests
//
//  Created by Coleton Gorecke on 3/30/24.
//
@testable import ComposableArch_Example
import ComposableArchitecture
import XCTest

@MainActor
final class ContactsFeatureTests: XCTestCase {
    private var store: TestStore<ContactsFeature.State, ContactsFeature.Action>!
    
    override func setUp() {
        super.setUp()
        
        store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
    }
    
    /// https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/composablearchitecture/02-03-testingpresentation
    func testAddFlow() async {
        await store.send(.addButtonTapped)
        await store.send(\.destination.addContact.setName, "Blob Jr.")
        await store.send(\.destination.addContact.saveButtonTapped)
        await store.skipReceivedActions()
        store.assert {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
            $0.destination = nil
        }
    }
}
