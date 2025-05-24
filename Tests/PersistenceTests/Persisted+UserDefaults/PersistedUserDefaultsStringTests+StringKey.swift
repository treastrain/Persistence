//
//  PersistedUserDefaultsStringTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let defaultValue = "abc"
private let anotherValue = "xyz"

struct PersistedUserDefaultsStringStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value"
    )
    var value = defaultValue

    @Test
    mutating func testValue() {
        #expect(value == defaultValue)
        value = anotherValue
        #expect(value == anotherValue)
    }
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value"
    )
    var optionalValue: String?

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = anotherValue
        #expect(optionalValue == anotherValue)
        optionalValue = nil
        #expect(optionalValue == nil)
    }
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformValue = defaultValue

    @Test
    mutating func testTransformValue() {
        #expect(transformValue == defaultValue)
        transformValue = anotherValue
        #expect(transformValue == anotherValue)
    }
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalValue: String?

    @Test
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = anotherValue
        #expect(transformOptionalValue == anotherValue)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }
}
