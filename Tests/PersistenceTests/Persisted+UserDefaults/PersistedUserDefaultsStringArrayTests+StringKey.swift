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
        key: "wrapped-value"
    )
    var wrappedValue = defaultArray

    @Test
    mutating func testWrappedValue() {
        #expect(wrappedValue == defaultArray)
        wrappedValue = anotherArray
        #expect(wrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: [String]? = nil

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue = defaultArray

    @Test
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == defaultArray)
        transformWrappedValue = anotherArray
        #expect(transformWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: [String]? = nil

    @Test
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = anotherArray
        #expect(transformOptionalWrappedValue == anotherArray)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
