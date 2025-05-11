//
//  PersistedUserDefaultsIntTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedUserDefaultsIntStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value",
        defaultValue: 0
    )
    var value

    @Test(.tags(.defaultValue))
    mutating func test() {
        #expect(value == 0)
        value = 1
        #expect(value == 1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "wrapped-value"
    )
    var wrappedValue = 0

    @Test(.tags(.wrappedValue))
    mutating func testWrappedValue() {
        #expect(wrappedValue == 0)
        wrappedValue = 1
        #expect(wrappedValue == 1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value",
        defaultValue: nil
    )
    var optionalValue: Int?

    @Test(.tags(.defaultValue))
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = 1
        #expect(optionalValue == 1)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: Int? = nil

    @Test(.tags(.wrappedValue))
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = 1
        #expect(optionalWrappedValue == 1)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: 0
    )
    var transformValue

    @Test(.tags(.defaultValue))
    mutating func testTransformValue() {
        #expect(transformValue == 0)
        transformValue = 1
        #expect(transformValue == 1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue = 0

    @Test(.tags(.wrappedValue))
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == 0)
        transformWrappedValue = 1
        #expect(transformWrappedValue == 1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var transformOptionalValue: Int?

    @Test(.tags(.defaultValue))
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = 1
        #expect(transformOptionalValue == 1)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: Int? = nil

    @Test(.tags(.wrappedValue))
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = 1
        #expect(transformOptionalWrappedValue == 1)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
