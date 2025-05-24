//
//  PersistedUserDefaultsStringArrayTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let defaultArray = ["a", "b", "c"]
private let anotherArray = ["x", "y"]

struct PersistedUserDefaultsStringArrayStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value"
    )
    var value = defaultArray

    @Test
    mutating func testValue() {
        #expect(value == defaultArray)
        value = anotherArray
        #expect(value == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value"
    )
    var optionalValue: [String]?

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformValue = defaultArray

    @Test
    mutating func testTransformValue() {
        #expect(transformValue == defaultArray)
        transformValue = anotherArray
        #expect(transformValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalValue: [String]?

    @Test
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = anotherArray
        #expect(transformOptionalValue == anotherArray)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }
}
