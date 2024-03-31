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
    
    func testAddFlow() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
        
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
    
    func testDeleteContact() async {
        let store = TestStore(
            initialState: ContactsFeature.State(
                contacts: [
                    Contact(id: UUID(0), name: "Blob"),
                    Contact(id: UUID(1), name: "Blob Jr."),
                ]
            )
        ) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
        
        // Emulate the user confirming to delete contact by sending the confirmDeletion action in the alert.
        await store.send(.deleteButtonTapped(id: UUID(1))) {
            $0.destination = .alert(.deleteConfirmation(id: UUID(1)))
        }
        
        // Assert that the alert was dismissed and that the contact corresponding to the ID of UUID(1) was removed.
        await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
            $0.contacts.remove(id: UUID(1))
            $0.destination = nil
        }
    }
}
