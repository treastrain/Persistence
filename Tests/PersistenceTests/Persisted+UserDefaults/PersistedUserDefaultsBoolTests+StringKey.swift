//
//  PersistedUserDefaultsBoolTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedUserDefaultsBoolStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value"
    )
    var value = false

    @Test
    mutating func testValue() {
        #expect(value == false)
        value = true
        #expect(value == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value"
    )
    var optionalValue: Bool?

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = true
        #expect(optionalValue == true)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformValue = false

    @Test
    mutating func testTransformValue() {
        #expect(transformValue == false)
        transformValue = true
        #expect(transformValue == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalValue: Bool?

    @Test
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = true
        #expect(transformOptionalValue == true)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }
}
