//
//  PersistedUserDefaultsURLTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let exampleComURL = URL(string: "https://example.com")!
private let exampleOrgURL = URL(string: "https://example.org")!

struct PersistedUserDefaultsURLStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value",
        defaultValue: exampleComURL
    )
    var value

    @Test(.tags(.defaultValue))
    mutating func test() {
        #expect(value == exampleComURL)
        value = exampleOrgURL
        #expect(value == exampleOrgURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "wrapped-value"
    )
    var wrappedValue = exampleComURL

    @Test(.tags(.wrappedValue))
    mutating func testWrappedValue() {
        #expect(wrappedValue == exampleComURL)
        wrappedValue = exampleOrgURL
        #expect(wrappedValue == exampleOrgURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value",
        defaultValue: nil
    )
    var optionalValue: URL?

    @Test(.tags(.defaultValue))
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = exampleOrgURL
        #expect(optionalValue == exampleOrgURL)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: URL? = nil

    @Test(.tags(.wrappedValue))
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = exampleOrgURL
        #expect(optionalWrappedValue == exampleOrgURL)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: exampleComURL
    )
    var transformValue

    @Test(.tags(.defaultValue))
    mutating func testTransformValue() {
        #expect(transformValue == exampleComURL)
        transformValue = exampleOrgURL
        #expect(transformValue == exampleOrgURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformWrappedValue = exampleComURL

    @Test(.tags(.wrappedValue))
    mutating func testTransformWrappedValue() {
        #expect(transformWrappedValue == exampleComURL)
        transformWrappedValue = exampleOrgURL
        #expect(transformWrappedValue == exampleOrgURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var transformOptionalValue: URL?

    @Test(.tags(.defaultValue))
    mutating func testTransformOptionalValue() {
        #expect(transformOptionalValue == nil)
        transformOptionalValue = exampleOrgURL
        #expect(transformOptionalValue == exampleOrgURL)
        transformOptionalValue = nil
        #expect(transformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "transform-optional-wrapped-value",
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var transformOptionalWrappedValue: URL? = nil

    @Test(.tags(.wrappedValue))
    mutating func testTransformOptionalWrappedValue() {
        #expect(transformOptionalWrappedValue == nil)
        transformOptionalWrappedValue = exampleOrgURL
        #expect(transformOptionalWrappedValue == exampleOrgURL)
        transformOptionalWrappedValue = nil
        #expect(transformOptionalWrappedValue == nil)
    }
}
