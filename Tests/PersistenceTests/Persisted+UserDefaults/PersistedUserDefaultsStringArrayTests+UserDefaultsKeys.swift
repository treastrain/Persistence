//
//  PersistedUserDefaultsStringArrayTests+UserDefaultsKeys.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let defaultArray = ["a", "b", "c"]
private let anotherArray = ["x", "y"]

struct PersistedUserDefaultsStringArrayUserDefaultsKeysTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.value,
        defaultValue: defaultArray
    )
    var userDefaultsKeysValue

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeys() {
        #expect(userDefaultsKeysValue == defaultArray)
        userDefaultsKeysValue = anotherArray
        #expect(userDefaultsKeysValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.wrappedValue
    )
    var userDefaultsKeysWrappedValue = defaultArray

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysWrappedValue() {
        #expect(userDefaultsKeysWrappedValue == defaultArray)
        userDefaultsKeysWrappedValue = anotherArray
        #expect(userDefaultsKeysWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalValue,
        defaultValue: nil
    )
    var userDefaultsKeysOptionalValue: [String]?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = anotherArray
        #expect(userDefaultsKeysOptionalValue == anotherArray)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalWrappedValue
    )
    var userDefaultsKeysOptionalWrappedValue: [String]? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysOptionalWrappedValue() {
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
        userDefaultsKeysOptionalWrappedValue = anotherArray
        #expect(userDefaultsKeysOptionalWrappedValue == anotherArray)
        userDefaultsKeysOptionalWrappedValue = nil
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: defaultArray
    )
    var userDefaultsKeysTransformValue

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == defaultArray)
        userDefaultsKeysTransformValue = anotherArray
        #expect(userDefaultsKeysTransformValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformWrappedValue = defaultArray

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformWrappedValue() {
        #expect(userDefaultsKeysTransformWrappedValue == defaultArray)
        userDefaultsKeysTransformWrappedValue = anotherArray
        #expect(userDefaultsKeysTransformWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var userDefaultsKeysTransformOptionalValue: [String]?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = anotherArray
        #expect(userDefaultsKeysTransformOptionalValue == anotherArray)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformOptionalWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalWrappedValue: [String]? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformOptionalWrappedValue() {
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
        userDefaultsKeysTransformOptionalWrappedValue = anotherArray
        #expect(userDefaultsKeysTransformOptionalWrappedValue == anotherArray)
        userDefaultsKeysTransformOptionalWrappedValue = nil
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
    }
}

private enum UserDefaultsKeys: String, UserDefaultsKey {
    case value
    case wrappedValue
    case optionalValue
    case optionalWrappedValue
    case transformValue
    case transformWrappedValue
    case transformOptionalValue
    case transformOptionalWrappedValue
}
