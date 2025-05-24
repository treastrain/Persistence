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
        key: UserDefaultsKeys.value
    )
    var userDefaultsKeysValue: Float = 0.0

    @Test
    mutating func testUserDefaultsKeysValue() {
        #expect(userDefaultsKeysValue == 0.0)
        userDefaultsKeysValue = 0.1
        #expect(userDefaultsKeysValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalValue
    )
    var userDefaultsKeysOptionalValue: Float? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = 0.1
        #expect(userDefaultsKeysOptionalValue == 0.1)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformValue: Float = 0.0

    @Test
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == 0.0)
        userDefaultsKeysTransformValue = 0.1
        #expect(userDefaultsKeysTransformValue == 0.1)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalValue: Float? = nil

    @Test
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = 0.1
        #expect(userDefaultsKeysTransformOptionalValue == 0.1)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }
}
