//
//  PersistedUserDefaultsURLTests+UserDefaultsKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let devNullURL = URL(fileURLWithPath: "/dev/null")
private let helloHappyWorldURL = URL(fileURLWithPath: "/hello/happy/world")

struct PersistedUserDefaultsURLUserDefaultsKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .value
    )
    var userDefaultsKeysValue = devNullURL

    @Test
    mutating func testUserDefaultsKeysValue() {
        #expect(userDefaultsKeysValue == devNullURL)
        userDefaultsKeysValue = helloHappyWorldURL
        #expect(userDefaultsKeysValue == helloHappyWorldURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalValue
    )
    var userDefaultsKeysOptionalValue: URL? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = helloHappyWorldURL
        #expect(userDefaultsKeysOptionalValue == helloHappyWorldURL)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformValue = devNullURL

    @Test
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == devNullURL)
        userDefaultsKeysTransformValue = helloHappyWorldURL
        #expect(userDefaultsKeysTransformValue == helloHappyWorldURL)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalValue: URL? = nil

    @Test
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = helloHappyWorldURL
        #expect(
            userDefaultsKeysTransformOptionalValue == helloHappyWorldURL
        )
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }
}
