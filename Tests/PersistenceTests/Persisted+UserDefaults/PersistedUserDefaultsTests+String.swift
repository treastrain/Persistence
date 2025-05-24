//
//  PersistedUserDefaultsTests+String.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

#if swift(>=6.1)
    import Foundation
    import Persistence
    import Testing

    private let defaultValue = "abc"
    private let anotherValue = "xyz"

    struct PersistedUserDefaultsStringTests: Sendable {
        // MARK: - String Key

        @Persisted(key: "value")
        var value = defaultValue

        @Test(.mockUserDefaults)
        mutating func testValue() {
            #expect(value == defaultValue)
            value = anotherValue
            #expect(value == anotherValue)
        }

        @Persisted(key: "optional-value")
        var optionalValue: String? = nil

        @Test(.mockUserDefaults)
        mutating func testOptionalValue() {
            #expect(optionalValue == nil)
            optionalValue = anotherValue
            #expect(optionalValue == anotherValue)
            optionalValue = nil
            #expect(optionalValue == nil)
        }

        @Persisted(
            key: "transform-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformValue = defaultValue

        @Test(.mockUserDefaults)
        mutating func testTransformValue() {
            #expect(transformValue == defaultValue)
            transformValue = anotherValue
            #expect(transformValue == anotherValue)
        }

        @Persisted(
            key: "transform-optional-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformOptionalValue: String? = nil

        @Test(.mockUserDefaults)
        mutating func testTransformOptionalValue() {
            #expect(transformOptionalValue == nil)
            transformOptionalValue = anotherValue
            #expect(transformOptionalValue == anotherValue)
            transformOptionalValue = nil
            #expect(transformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKey

        @Persisted(key: .value)
        var userDefaultsKeyValue = defaultValue

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyValue() {
            #expect(userDefaultsKeyValue == defaultValue)
            userDefaultsKeyValue = anotherValue
            #expect(userDefaultsKeyValue == anotherValue)
        }

        @Persisted(key: .optionalValue)
        var userDefaultsKeyOptionalValue: String? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyOptionalValue() {
            #expect(userDefaultsKeyOptionalValue == nil)
            userDefaultsKeyOptionalValue = anotherValue
            #expect(userDefaultsKeyOptionalValue == anotherValue)
            userDefaultsKeyOptionalValue = nil
            #expect(userDefaultsKeyOptionalValue == nil)
        }

        @Persisted(
            key: .transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformValue = defaultValue

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformValue() {
            #expect(userDefaultsKeyTransformValue == defaultValue)
            userDefaultsKeyTransformValue = anotherValue
            #expect(userDefaultsKeyTransformValue == anotherValue)
        }

        @Persisted(
            key: .transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformOptionalValue: String? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformOptionalValue() {
            #expect(userDefaultsKeyTransformOptionalValue == nil)
            userDefaultsKeyTransformOptionalValue = anotherValue
            #expect(userDefaultsKeyTransformOptionalValue == anotherValue)
            userDefaultsKeyTransformOptionalValue = nil
            #expect(userDefaultsKeyTransformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKeys

        @Persisted(key: UserDefaultsKeys.value)
        var userDefaultsKeysValue = defaultValue

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysValue() {
            #expect(userDefaultsKeysValue == defaultValue)
            userDefaultsKeysValue = anotherValue
            #expect(userDefaultsKeysValue == anotherValue)
        }

        @Persisted(key: UserDefaultsKeys.optionalValue)
        var userDefaultsKeysOptionalValue: String? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysOptionalValue() {
            #expect(userDefaultsKeysOptionalValue == nil)
            userDefaultsKeysOptionalValue = anotherValue
            #expect(userDefaultsKeysOptionalValue == anotherValue)
            userDefaultsKeysOptionalValue = nil
            #expect(userDefaultsKeysOptionalValue == nil)
        }

        @Persisted(
            key: UserDefaultsKeys.transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformValue = defaultValue

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformValue() {
            #expect(userDefaultsKeysTransformValue == defaultValue)
            userDefaultsKeysTransformValue = anotherValue
            #expect(userDefaultsKeysTransformValue == anotherValue)
        }

        @Persisted(
            key: UserDefaultsKeys.transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformOptionalValue: String? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformOptionalValue() {
            #expect(userDefaultsKeysTransformOptionalValue == nil)
            userDefaultsKeysTransformOptionalValue = anotherValue
            #expect(userDefaultsKeysTransformOptionalValue == anotherValue)
            userDefaultsKeysTransformOptionalValue = nil
            #expect(userDefaultsKeysTransformOptionalValue == nil)
        }
    }
#endif
