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
        key: "wrapped-value"
    )
    var wrappedValue = defaultValue

    @Test
    mutating func testWrappedValue() {
        #expect(wrappedValue == defaultValue)
        wrappedValue = anotherValue
        #expect(wrappedValue == anotherValue)
    }
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: String? = nil

    @Test
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = anotherValue
        #expect(optionalWrappedValue == anotherValue)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue = defaultValue

    @Test
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == defaultValue)
        transformWrappedValue = anotherValue
        #expect(transformWrappedValue == anotherValue)
    }
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: String? = nil

    @Test
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = anotherValue
        #expect(transformOptionalWrappedValue == anotherValue)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
