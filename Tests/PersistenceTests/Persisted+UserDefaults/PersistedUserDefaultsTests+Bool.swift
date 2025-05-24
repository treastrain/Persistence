//
//  PersistedUserDefaultsTests+Bool.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

#if swift(>=6.1)
    import Foundation
    import Persistence
    import Testing

    struct PersistedUserDefaultsBoolTests: Sendable {
        // MARK: - String Key

        @Persisted(key: "value")
        var value = false

        @Test(.mockUserDefaults)
        mutating func testValue() {
            #expect(value == false)
            value = true
            #expect(value == true)
        }

        @Persisted(key: "optional-value")
        var optionalValue: Bool?

        @Test(.mockUserDefaults)
        mutating func testOptionalValue() {
            #expect(optionalValue == nil)
            optionalValue = true
            #expect(optionalValue == true)
            optionalValue = nil
            #expect(optionalValue == nil)
        }

        @Persisted(
            key: "transform-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformValue = false

        @Test(.mockUserDefaults)
        mutating func testTransformValue() {
            #expect(transformValue == false)
            transformValue = true
            #expect(transformValue == true)
        }

        @Persisted(
            key: "transform-optional-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformOptionalValue: Bool?

        @Test(.mockUserDefaults)
        mutating func testTransformOptionalValue() {
            #expect(transformOptionalValue == nil)
            transformOptionalValue = true
            #expect(transformOptionalValue == true)
            transformOptionalValue = nil
            #expect(transformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKey

        @Persisted(key: .value)
        var userDefaultsKeyValue = false

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyValue() {
            #expect(userDefaultsKeyValue == false)
            userDefaultsKeyValue = true
            #expect(userDefaultsKeyValue == true)
        }

        @Persisted(key: .optionalValue)
        var userDefaultsKeyOptionalValue: Bool?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyOptionalValue() {
            #expect(userDefaultsKeyOptionalValue == nil)
            userDefaultsKeyOptionalValue = true
            #expect(userDefaultsKeyOptionalValue == true)
            userDefaultsKeyOptionalValue = nil
            #expect(userDefaultsKeyOptionalValue == nil)
        }

        @Persisted(
            key: .transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformValue = false

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformValue() {
            #expect(userDefaultsKeyTransformValue == false)
            userDefaultsKeyTransformValue = true
            #expect(userDefaultsKeyTransformValue == true)
        }

        @Persisted(
            key: .transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformOptionalValue: Bool?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformOptionalValue() {
            #expect(userDefaultsKeyTransformOptionalValue == nil)
            userDefaultsKeyTransformOptionalValue = true
            #expect(userDefaultsKeyTransformOptionalValue == true)
            userDefaultsKeyTransformOptionalValue = nil
            #expect(userDefaultsKeyTransformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKeys

        @Persisted(key: UserDefaultsKeys.value)
        var userDefaultsKeysValue = false

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysValue() {
            #expect(userDefaultsKeysValue == false)
            userDefaultsKeysValue = true
            #expect(userDefaultsKeysValue == true)
        }

        @Persisted(key: UserDefaultsKeys.optionalValue)
        var userDefaultsKeysOptionalValue: Bool?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysOptionalValue() {
            #expect(userDefaultsKeysOptionalValue == nil)
            userDefaultsKeysOptionalValue = true
            #expect(userDefaultsKeysOptionalValue == true)
            userDefaultsKeysOptionalValue = nil
            #expect(userDefaultsKeysOptionalValue == nil)
        }

        @Persisted(
            key: UserDefaultsKeys.transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformValue = false

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformValue() {
            #expect(userDefaultsKeysTransformValue == false)
            userDefaultsKeysTransformValue = true
            #expect(userDefaultsKeysTransformValue == true)
        }

        @Persisted(
            key: UserDefaultsKeys.transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformOptionalValue: Bool?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformOptionalValue() {
            #expect(userDefaultsKeysTransformOptionalValue == nil)
            userDefaultsKeysTransformOptionalValue = true
            #expect(userDefaultsKeysTransformOptionalValue == true)
            userDefaultsKeysTransformOptionalValue = nil
            #expect(userDefaultsKeysTransformOptionalValue == nil)
        }
    }
#endif
