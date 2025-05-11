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
        key: "value",
        defaultValue: defaultValue
    )
    var value

    @Test(.tags(.defaultValue))
    mutating func test() {
        #expect(value == defaultValue)
        value = anotherValue
        #expect(value == anotherValue)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "wrapped-value"
    )
    var wrappedValue = defaultValue

    @Test(.tags(.wrappedValue))
    mutating func testWrappedValue() {
        #expect(wrappedValue == defaultValue)
        wrappedValue = anotherValue
        #expect(wrappedValue == anotherValue)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value",
        defaultValue: nil
    )
    var optionalValue: String?

    @Test(.tags(.defaultValue))
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = anotherValue
        #expect(optionalValue == anotherValue)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: String? = nil

    @Test(.tags(.wrappedValue))
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = anotherValue
        #expect(optionalWrappedValue == anotherValue)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: defaultValue
    )
    var transformValue

    @Test(.tags(.defaultValue))
    mutating func testTransformValue() {
        #expect(transformValue == defaultValue)
        transformValue = anotherValue
        #expect(transformValue == anotherValue)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue = defaultValue

    @Test(.tags(.wrappedValue))
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == defaultValue)
        transformWrappedValue = anotherValue
        #expect(transformWrappedValue == anotherValue)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var transformOptionalValue: String?

    @Test(.tags(.defaultValue))
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = anotherValue
        #expect(transformOptionalValue == anotherValue)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: String? = nil

    @Test(.tags(.wrappedValue))
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = anotherValue
        #expect(transformOptionalWrappedValue == anotherValue)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
