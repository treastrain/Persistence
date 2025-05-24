//
//  PersistedUserDefaultsBoolTests+UserDefaultsKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedUserDefaultsBoolUserDefaultsKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .value
    )
    var userDefaultsKeysValue = false

    @Test
    mutating func testUserDefaultsKeysValue() {
        #expect(userDefaultsKeysValue == false)
        userDefaultsKeysValue = true
        #expect(userDefaultsKeysValue == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalValue
    )
    var userDefaultsKeysOptionalValue: Bool? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = true
        #expect(userDefaultsKeysOptionalValue == true)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformValue = false

    @Test
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == false)
        userDefaultsKeysTransformValue = true
        #expect(userDefaultsKeysTransformValue == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalValue: Bool? = nil

    @Test
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = true
        #expect(userDefaultsKeysTransformOptionalValue == true)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }
}
