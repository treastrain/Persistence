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
        key: "value",
        defaultValue: defaultArray
    )
    var value

    @Test(.tags(.defaultValue))
    mutating func test() {
        #expect(value == defaultArray)
        value = anotherArray
        #expect(value == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "wrapped-value"
    )
    var wrappedValue = defaultArray

    @Test(.tags(.wrappedValue))
    mutating func testWrappedValue() {
        #expect(wrappedValue == defaultArray)
        wrappedValue = anotherArray
        #expect(wrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value",
        defaultValue: nil
    )
    var optionalValue: [String]?

    @Test(.tags(.defaultValue))
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = anotherArray
        #expect(optionalValue == anotherArray)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: [String]? = nil

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: defaultArray
    )
    var transformValue

    @Test(.tags(.defaultValue))
    mutating func testTransformValue() {
        #expect(transformValue == defaultArray)
        transformValue = anotherArray
        #expect(transformValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue = defaultArray

    @Test(.tags(.wrappedValue))
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == defaultArray)
        transformWrappedValue = anotherArray
        #expect(transformWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var transformOptionalValue: [String]?

    @Test(.tags(.defaultValue))
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = anotherArray
        #expect(transformOptionalValue == anotherArray)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: [String]? = nil

    @Test(.tags(.wrappedValue))
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = anotherArray
        #expect(transformOptionalWrappedValue == anotherArray)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
