//
//  PersistedUserDefaultsTests+URL.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

#if swift(>=6.1)
    import Foundation
    import Persistence
    import Testing

    private let devNullURL = URL(fileURLWithPath: "/dev/null")
    private let helloHappyWorldURL = URL(fileURLWithPath: "/hello/happy/world")

    struct PersistedUserDefaultsURLTests: Sendable {
        // MARK: - String Key

        @Persisted(key: "value")
        var value = devNullURL

        @Test(.mockUserDefaults)
        mutating func testValue() {
            #expect(value == devNullURL)
            value = helloHappyWorldURL
            #expect(value == helloHappyWorldURL)
        }

        @Persisted(key: "optional-value")
        var optionalValue: URL? = nil

        @Test(.mockUserDefaults)
        mutating func testOptionalValue() {
            #expect(optionalValue == nil)
            optionalValue = helloHappyWorldURL
            #expect(optionalValue == helloHappyWorldURL)
            optionalValue = nil
            #expect(optionalValue == nil)
        }

        @Persisted(
            key: "transform-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformValue = devNullURL

        @Test(.mockUserDefaults)
        mutating func testTransformValue() {
            #expect(transformValue == devNullURL)
            transformValue = helloHappyWorldURL
            #expect(transformValue == helloHappyWorldURL)
        }

        @Persisted(
            key: "transform-optional-value",
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var transformOptionalValue: URL? = nil

        @Test(.mockUserDefaults)
        mutating func testTransformOptionalValue() {
            #expect(transformOptionalValue == nil)
            transformOptionalValue = helloHappyWorldURL
            #expect(transformOptionalValue == helloHappyWorldURL)
            transformOptionalValue = nil
            #expect(transformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKey

        @Persisted(key: .value)
        var userDefaultsKeyValue = devNullURL

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyValue() {
            #expect(userDefaultsKeyValue == devNullURL)
            userDefaultsKeyValue = helloHappyWorldURL
            #expect(userDefaultsKeyValue == helloHappyWorldURL)
        }

        @Persisted(key: .optionalValue)
        var userDefaultsKeyOptionalValue: URL? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyOptionalValue() {
            #expect(userDefaultsKeyOptionalValue == nil)
            userDefaultsKeyOptionalValue = helloHappyWorldURL
            #expect(userDefaultsKeyOptionalValue == helloHappyWorldURL)
            userDefaultsKeyOptionalValue = nil
            #expect(userDefaultsKeyOptionalValue == nil)
        }

        @Persisted(
            key: .transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformValue = devNullURL

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformValue() {
            #expect(userDefaultsKeyTransformValue == devNullURL)
            userDefaultsKeyTransformValue = helloHappyWorldURL
            #expect(userDefaultsKeyTransformValue == helloHappyWorldURL)
        }

        @Persisted(
            key: .transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeyTransformOptionalValue: URL? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyTransformOptionalValue() {
            #expect(userDefaultsKeyTransformOptionalValue == nil)
            userDefaultsKeyTransformOptionalValue = helloHappyWorldURL
            #expect(userDefaultsKeyTransformOptionalValue == helloHappyWorldURL)
            userDefaultsKeyTransformOptionalValue = nil
            #expect(userDefaultsKeyTransformOptionalValue == nil)
        }

        // MARK: - UserDefaultsKeys

        @Persisted(key: UserDefaultsKeys.value)
        var userDefaultsKeysValue = devNullURL

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysValue() {
            #expect(userDefaultsKeysValue == devNullURL)
            userDefaultsKeysValue = helloHappyWorldURL
            #expect(userDefaultsKeysValue == helloHappyWorldURL)
        }

        @Persisted(key: UserDefaultsKeys.optionalValue)
        var userDefaultsKeysOptionalValue: URL? = nil

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysOptionalValue() {
            #expect(userDefaultsKeysOptionalValue == nil)
            userDefaultsKeysOptionalValue = helloHappyWorldURL
            #expect(userDefaultsKeysOptionalValue == helloHappyWorldURL)
            userDefaultsKeysOptionalValue = nil
            #expect(userDefaultsKeysOptionalValue == nil)
        }

        @Persisted(
            key: UserDefaultsKeys.transformValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformValue = devNullURL

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysTransformValue() {
            #expect(userDefaultsKeysTransformValue == devNullURL)
            userDefaultsKeysTransformValue = helloHappyWorldURL
            #expect(userDefaultsKeysTransformValue == helloHappyWorldURL)
        }

        @Persisted(
            key: UserDefaultsKeys.transformOptionalValue,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
        var userDefaultsKeysTransformOptionalValue: URL? = nil

        @Test(.mockUserDefaults)
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
#endif
