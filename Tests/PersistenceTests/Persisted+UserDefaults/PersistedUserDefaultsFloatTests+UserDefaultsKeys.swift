//
//  PersistedUserDefaultsFloatTests+UserDefaultsKeys.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedUserDefaultsFloatUserDefaultsKeysTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.value,
        defaultValue: 0.0
    )
    var userDefaultsKeysValue: Float

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeys() {
        #expect(userDefaultsKeysValue == 0.0)
        userDefaultsKeysValue = 0.1
        #expect(userDefaultsKeysValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.wrappedValue
    )
    var userDefaultsKeysWrappedValue: Float = 0.0

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysWrappedValue() {
        #expect(userDefaultsKeysWrappedValue == 0.0)
        userDefaultsKeysWrappedValue = 0.1
        #expect(userDefaultsKeysWrappedValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalValue,
        defaultValue: nil
    )
    var userDefaultsKeysOptionalValue: Float?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = 0.1
        #expect(userDefaultsKeysOptionalValue == 0.1)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalWrappedValue
    )
    var userDefaultsKeysOptionalWrappedValue: Float? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysOptionalWrappedValue() {
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
        userDefaultsKeysOptionalWrappedValue = 0.1
        #expect(userDefaultsKeysOptionalWrappedValue == 0.1)
        userDefaultsKeysOptionalWrappedValue = nil
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: 0.0
    )
    var userDefaultsKeysTransformValue: Float

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == 0.0)
        userDefaultsKeysTransformValue = 0.1
        #expect(userDefaultsKeysTransformValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformWrappedValue: Float = 0.0

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformWrappedValue() {
        #expect(userDefaultsKeysTransformWrappedValue == 0.0)
        userDefaultsKeysTransformWrappedValue = 0.1
        #expect(userDefaultsKeysTransformWrappedValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var userDefaultsKeysTransformOptionalValue: Float?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = 0.1
        #expect(userDefaultsKeysTransformOptionalValue == 0.1)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformOptionalWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalWrappedValue: Float? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformOptionalWrappedValue() {
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
        userDefaultsKeysTransformOptionalWrappedValue = 0.1
        #expect(userDefaultsKeysTransformOptionalWrappedValue == 0.1)
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
