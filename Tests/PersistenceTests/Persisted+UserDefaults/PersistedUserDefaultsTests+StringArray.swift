//
//  PersistedUserDefaultsTests+StringArray.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

#if swift(>=6.1)
    import Foundation
    import Persistence
    import Testing

    private let defaultArray = ["a", "b", "c"]
    private let anotherArray = ["x", "y"]

    struct PersistedUserDefaultsStringArrayTests: Sendable {
        // MARK: - String Key

        @Persisted(key: "value")
        var value = defaultArray

        @Test(.mockUserDefaults)
        mutating func testValue() {
            #expect(value == defaultArray)
            value = anotherArray
            #expect(value == anotherArray)
        }

        @Persisted(key: "optional-value")
        var optionalValue: [String]?

        @Test(.mockUserDefaults)
        mutating func testOptionalValue() {
            #expect(optionalValue == nil)
            optionalValue = anotherArray
            #expect(optionalValue == anotherArray)
            optionalValue = nil
            #expect(optionalValue == nil)
        }

        @Persisted(
            key: "transform-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformValue = defaultArray

        @Test(.mockUserDefaults)
        mutating func testTransformValue() {
            #expect(transformValue == defaultArray)
            transformValue = anotherArray
            #expect(transformValue == anotherArray)
        }

        @Persisted(
            key: "transform-optional-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformOptionalValue: [String]?

        @Test(.mockUserDefaults)
        mutating func testTransformOptionalValue() {
            #expect(transformOptionalValue == nil)
            transformOptionalValue = anotherArray
            #expect(transformOptionalValue == anotherArray)
            transformOptionalValue = nil
            #expect(transformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKey

        @Persisted(key: .value)
        var userDefaultsKeyValue = defaultArray

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyValue() {
            #expect(userDefaultsKeyValue == defaultArray)
            userDefaultsKeyValue = anotherArray
            #expect(userDefaultsKeyValue == anotherArray)
        }

        @Persisted(key: .optionalValue)
        var userDefaultsKeyOptionalValue: [String]?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyOptionalValue() {
            #expect(userDefaultsKeyOptionalValue == nil)
            userDefaultsKeyOptionalValue = anotherArray
            #expect(userDefaultsKeyOptionalValue == anotherArray)
            userDefaultsKeyOptionalValue = nil
            #expect(userDefaultsKeyOptionalValue == nil)
        }

        @Persisted(
            key: .transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformValue = defaultArray

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformValue() {
            #expect(userDefaultsKeyTransformValue == defaultArray)
            userDefaultsKeyTransformValue = anotherArray
            #expect(userDefaultsKeyTransformValue == anotherArray)
        }

        @Persisted(
            key: .transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformOptionalValue: [String]?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformOptionalValue() {
            #expect(userDefaultsKeyTransformOptionalValue == nil)
            userDefaultsKeyTransformOptionalValue = anotherArray
            #expect(userDefaultsKeyTransformOptionalValue == anotherArray)
            userDefaultsKeyTransformOptionalValue = nil
            #expect(userDefaultsKeyTransformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKeys

        @Persisted(key: UserDefaultsKeys.value)
        var userDefaultsKeysValue = defaultArray

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysValue() {
            #expect(userDefaultsKeysValue == defaultArray)
            userDefaultsKeysValue = anotherArray
            #expect(userDefaultsKeysValue == anotherArray)
        }

        @Persisted(key: UserDefaultsKeys.optionalValue)
        var userDefaultsKeysOptionalValue: [String]?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysOptionalValue() {
            #expect(userDefaultsKeysOptionalValue == nil)
            userDefaultsKeysOptionalValue = anotherArray
            #expect(userDefaultsKeysOptionalValue == anotherArray)
            userDefaultsKeysOptionalValue = nil
            #expect(userDefaultsKeysOptionalValue == nil)
        }

        @Persisted(
            key: UserDefaultsKeys.transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformValue = defaultArray

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformValue() {
            #expect(userDefaultsKeysTransformValue == defaultArray)
            userDefaultsKeysTransformValue = anotherArray
            #expect(userDefaultsKeysTransformValue == anotherArray)
        }

        @Persisted(
            key: UserDefaultsKeys.transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformOptionalValue: [String]?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformOptionalValue() {
            #expect(userDefaultsKeysTransformOptionalValue == nil)
            userDefaultsKeysTransformOptionalValue = anotherArray
            #expect(userDefaultsKeysTransformOptionalValue == anotherArray)
            userDefaultsKeysTransformOptionalValue = nil
            #expect(userDefaultsKeysTransformOptionalValue == nil)
        }
    }
#endif
