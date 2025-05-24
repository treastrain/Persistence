//
//  PersistedUserDefaultsStringTests+UserDefaultsKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let defaultValue = "abc"
private let anotherValue = "xyz"

struct PersistedUserDefaultsStringUserDefaultsKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .value
    )
    var userDefaultsKeysValue = defaultValue

    @Test
    mutating func testUserDefaultsKeysValue() {
        #expect(userDefaultsKeysValue == defaultValue)
        userDefaultsKeysValue = anotherValue
        #expect(userDefaultsKeysValue == anotherValue)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalValue
    )
    var userDefaultsKeysOptionalValue: String? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = anotherValue
        #expect(userDefaultsKeysOptionalValue == anotherValue)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformValue = defaultValue

    @Test
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == defaultValue)
        userDefaultsKeysTransformValue = anotherValue
        #expect(userDefaultsKeysTransformValue == anotherValue)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalValue: String? = nil

    @Test
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = anotherValue
        #expect(userDefaultsKeysTransformOptionalValue == anotherValue)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }
}
