//
//  PersistedUserDefaultsTests+Float.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

#if swift(>=6.1)
    import Foundation
    import Persistence
    import Testing

    struct PersistedUserDefaultsFloatTests: Sendable {
        // MARK: - String Key

        @Persisted(key: "value")
        var value: Float = 0.0

        @Test(.mockUserDefaults)
        mutating func testValue() {
            #expect(value == 0.0)
            value = 0.1
            #expect(value == 0.1)
        }

        @Persisted(key: "optional-value")
        var optionalValue: Float? = nil

        @Test(.mockUserDefaults)
        mutating func testOptionalValue() {
            #expect(optionalValue == nil)
            optionalValue = 0.1
            #expect(optionalValue == 0.1)
            optionalValue = nil
            #expect(optionalValue == nil)
        }

        @Persisted(
            key: "transform-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformValue: Float = 0.0

        @Test(.mockUserDefaults)
        mutating func testTransformValue() {
            #expect(transformValue == 0.0)
            transformValue = 0.1
            #expect(transformValue == 0.1)
        }

        @Persisted(
            key: "transform-optional-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformOptionalValue: Float? = nil

        @Test(.mockUserDefaults)
        mutating func testTransformOptionalValue() {
            #expect(transformOptionalValue == nil)
            transformOptionalValue = 0.1
            #expect(transformOptionalValue == 0.1)
            transformOptionalValue = nil
            #expect(transformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKey

        @Persisted(key: .value)
        var userDefaultsKeyValue: Float = 0.0

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyValue() {
            #expect(userDefaultsKeyValue == 0.0)
            userDefaultsKeyValue = 0.1
            #expect(userDefaultsKeyValue == 0.1)
        }

        @Persisted(key: .optionalValue)
        var userDefaultsKeyOptionalValue: Float? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyOptionalValue() {
            #expect(userDefaultsKeyOptionalValue == nil)
            userDefaultsKeyOptionalValue = 0.1
            #expect(userDefaultsKeyOptionalValue == 0.1)
            userDefaultsKeyOptionalValue = nil
            #expect(userDefaultsKeyOptionalValue == nil)
        }

        @Persisted(
            key: .transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformValue: Float = 0.0

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformValue() {
            #expect(userDefaultsKeyTransformValue == 0.0)
            userDefaultsKeyTransformValue = 0.1
            #expect(userDefaultsKeyTransformValue == 0.1)
        }

        @Persisted(
            key: .transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformOptionalValue: Float? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformOptionalValue() {
            #expect(userDefaultsKeyTransformOptionalValue == nil)
            userDefaultsKeyTransformOptionalValue = 0.1
            #expect(userDefaultsKeyTransformOptionalValue == 0.1)
            userDefaultsKeyTransformOptionalValue = nil
            #expect(userDefaultsKeyTransformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKeys

        @Persisted(key: UserDefaultsKeys.value)
        var userDefaultsKeysValue: Float = 0.0

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysValue() {
            #expect(userDefaultsKeysValue == 0.0)
            userDefaultsKeysValue = 0.1
            #expect(userDefaultsKeysValue == 0.1)
        }

        @Persisted(key: UserDefaultsKeys.optionalValue)
        var userDefaultsKeysOptionalValue: Float? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysOptionalValue() {
            #expect(userDefaultsKeysOptionalValue == nil)
            userDefaultsKeysOptionalValue = 0.1
            #expect(userDefaultsKeysOptionalValue == 0.1)
            userDefaultsKeysOptionalValue = nil
            #expect(userDefaultsKeysOptionalValue == nil)
        }

        @Persisted(
            key: UserDefaultsKeys.transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformValue: Float = 0.0

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformValue() {
            #expect(userDefaultsKeysTransformValue == 0.0)
            userDefaultsKeysTransformValue = 0.1
            #expect(userDefaultsKeysTransformValue == 0.1)
        }

        @Persisted(
            key: UserDefaultsKeys.transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformOptionalValue: Float? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformOptionalValue() {
            #expect(userDefaultsKeysTransformOptionalValue == nil)
            userDefaultsKeysTransformOptionalValue = 0.1
            #expect(userDefaultsKeysTransformOptionalValue == 0.1)
            userDefaultsKeysTransformOptionalValue = nil
            #expect(userDefaultsKeysTransformOptionalValue == nil)
        }
    }
#endif
