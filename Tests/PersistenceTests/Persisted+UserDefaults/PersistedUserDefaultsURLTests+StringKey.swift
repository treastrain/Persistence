//
//  PersistedUserDefaultsURLTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let devNullURL = URL(fileURLWithPath: "/dev/null")
private let helloHappyWorldURL = URL(fileURLWithPath: "/hello/happy/world")

struct PersistedUserDefaultsURLStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value"
    )
    var value = devNullURL

    @Test
    mutating func testValue() {
        #expect(value == devNullURL)
        value = helloHappyWorldURL
        #expect(value == helloHappyWorldURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value"
    )
    var optionalValue: URL? = nil

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = helloHappyWorldURL
        #expect(optionalValue == helloHappyWorldURL)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformValue = devNullURL

    @Test
    mutating func testTransformValue() {
        #expect(transformValue == devNullURL)
        transformValue = helloHappyWorldURL
        #expect(transformValue == helloHappyWorldURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalValue: URL? = nil

    @Test
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = helloHappyWorldURL
        #expect(transformOptionalValue == helloHappyWorldURL)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }
}
