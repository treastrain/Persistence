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
        key: "wrapped-value"
    )
    var wrappedValue = devNullURL

    @Test
    mutating func testWrappedValue() {
        #expect(wrappedValue == devNullURL)
        wrappedValue = helloHappyWorldURL
        #expect(wrappedValue == helloHappyWorldURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: URL? = nil

    @Test
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = helloHappyWorldURL
        #expect(optionalWrappedValue == helloHappyWorldURL)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue = devNullURL

    @Test
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == devNullURL)
        transformWrappedValue = helloHappyWorldURL
        #expect(transformWrappedValue == helloHappyWorldURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: URL? = nil

    @Test
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = helloHappyWorldURL
        #expect(transformOptionalWrappedValue == helloHappyWorldURL)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
