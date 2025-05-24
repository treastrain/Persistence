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
        key: "value"
    )
    var value = 0

    @Test
    mutating func testValue() {
        #expect(value == 0)
        value = 1
        #expect(value == 1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value"
    )
    var optionalValue: Int? = nil

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = 1
        #expect(optionalValue == 1)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformValue = 0

    @Test
    mutating func testTransformValue() {
        #expect(transformValue == 0)
        transformValue = 1
        #expect(transformValue == 1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalValue: Int? = nil

    @Test
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = 1
        #expect(transformOptionalValue == 1)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }
}
