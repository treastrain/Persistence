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
        key: UserDefaultsKeys.value
    )
    var userDefaultsKeysValue = defaultArray

    @Test
    mutating func testUserDefaultsKeysValue() {
        #expect(userDefaultsKeysValue == defaultArray)
        userDefaultsKeysValue = anotherArray
        #expect(userDefaultsKeysValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalValue
    )
    var userDefaultsKeysOptionalValue: [String]? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = anotherArray
        #expect(userDefaultsKeysOptionalValue == anotherArray)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformValue = defaultArray

    @Test
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == defaultArray)
        userDefaultsKeysTransformValue = anotherArray
        #expect(userDefaultsKeysTransformValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalValue: [String]? = nil

    @Test
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = anotherArray
        #expect(userDefaultsKeysTransformOptionalValue == anotherArray)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }
}
