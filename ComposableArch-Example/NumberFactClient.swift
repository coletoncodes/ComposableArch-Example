//
//  NumberFactClient.swift
//  ComposableArch-Example
//
//  Created by Coleton Gorecke on 3/30/24.
//

import ComposableArchitecture
import Foundation

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static let liveValue: NumberFactClient = {
        Self(
            fetch: { number in
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\(number)")!)
                return String(decoding: data, as: UTF8.self)
            }
        )
    }()
    
    static let previewValue: NumberFactClient = {
        Self(
            fetch: { number in
                return "Random fact about number: \(number)"
            }
        )
    }()
    
    static let testValue: NumberFactClient = {
        Self(
            fetch: { number in
                return "\(number) is a good number"
            }
        )
    }()
}

extension DependencyValues {
    var numberFactClient: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
