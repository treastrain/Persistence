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
        key: "value"
    )
    var value: Float = 0.0

    @Test
    mutating func testValue() {
        #expect(value == 0.0)
        value = 0.1
        #expect(value == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value"
    )
    var optionalValue: Float? = nil

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = 0.1
        #expect(optionalValue == 0.1)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformValue: Float = 0.0

    @Test
    mutating func testTransformValue() {
        #expect(transformValue == 0.0)
        transformValue = 0.1
        #expect(transformValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalValue: Float? = nil

    @Test
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = 0.1
        #expect(transformOptionalValue == 0.1)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }
}
