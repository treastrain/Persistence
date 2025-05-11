//
//  PersistedUserDefaultsFloatTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedUserDefaultsFloatStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value",
        defaultValue: 0.0
    )
    var value: Float

    @Test(.tags(.defaultValue))
    mutating func test() {
        #expect(value == 0.0)
        value = 0.1
        #expect(value == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "wrapped-value"
    )
    var wrappedValue: Float = 0.0

    @Test(.tags(.wrappedValue))
    mutating func testWrappedValue() {
        #expect(wrappedValue == 0.0)
        wrappedValue = 0.1
        #expect(wrappedValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value",
        defaultValue: nil
    )
    var optionalValue: Float?

    @Test(.tags(.defaultValue))
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = 0.1
        #expect(optionalValue == 0.1)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: Float? = nil

    @Test(.tags(.wrappedValue))
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = 0.1
        #expect(optionalWrappedValue == 0.1)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: 0.0
    )
    var transformValue: Float

    @Test(.tags(.defaultValue))
    mutating func testTransformValue() {
        #expect(transformValue == 0.0)
        transformValue = 0.1
        #expect(transformValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue: Float = 0.0

    @Test(.tags(.wrappedValue))
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == 0.0)
        transformWrappedValue = 0.1
        #expect(transformWrappedValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var transformOptionalValue: Float?

    @Test(.tags(.defaultValue))
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = 0.1
        #expect(transformOptionalValue == 0.1)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: Float? = nil

    @Test(.tags(.wrappedValue))
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = 0.1
        #expect(transformOptionalWrappedValue == 0.1)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
