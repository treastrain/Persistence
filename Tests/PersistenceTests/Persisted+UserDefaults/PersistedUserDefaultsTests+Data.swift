//
//  PersistedUserDefaultsTests+Data.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

#if swift(>=6.1)
    import Foundation
    import Persistence
    import Testing

    private let data1 = Data(repeating: 0x1, count: 16)
    private let data2 = Data(repeating: 0x2, count: 16)

    struct PersistedUserDefaultsDataTests: Sendable {
        // MARK: - String Key

        @Persisted(key: "value")
        var value = data1

        @Test(.mockUserDefaults)
        mutating func testValue() {
            #expect(value == data1)
            value = data2
            #expect(value == data2)
        }

        @Persisted(key: "optional-value")
        var optionalValue: Data?

        @Test(.mockUserDefaults)
        mutating func testOptionalValue() {
            #expect(optionalValue == nil)
            optionalValue = data2
            #expect(optionalValue == data2)
            optionalValue = nil
            #expect(optionalValue == nil)
        }

        @Persisted(
            key: "custom-data",
            transformForGetting: {
                try! JSONDecoder().decode(CustomData.self, from: $0)
            },
            transformForSetting: {
                try! JSONEncoder().encode($0)
            }
        )
        var customData = CustomData(value: 0)

        @Test(.mockUserDefaults)
        mutating func testCustomData() {
            #expect(customData == CustomData(value: 0))
            customData = CustomData(value: 1)
            #expect(customData == CustomData(value: 1))
        }

        @Persisted(
            key: "optional-custom-data",
            transformForGetting: {
                try! JSONDecoder().decode(CustomData?.self, from: $0)
            },
            transformForSetting: {
                try! JSONEncoder().encode($0)
            }
        )
        var optionalCustomData: CustomData?

        @Test(.mockUserDefaults)
        mutating func testOptionalCustomData() {
            #expect(optionalCustomData == nil)
            optionalCustomData = CustomData(value: 1)
            #expect(optionalCustomData == CustomData(value: 1))
            optionalCustomData = nil
            #expect(optionalCustomData == nil)
        }

        // MARK: - UserDefaultsKey

        @Persisted(key: .value)
        var userDefaultsKeyValue = data1

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyValue() {
            #expect(userDefaultsKeyValue == data1)
            userDefaultsKeyValue = data2
            #expect(userDefaultsKeyValue == data2)
        }

        @Persisted(key: .optionalValue)
        var userDefaultsKeyOptionalValue: Data?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyOptionalValue() {
            #expect(userDefaultsKeyOptionalValue == nil)
            userDefaultsKeyOptionalValue = data2
            #expect(userDefaultsKeyOptionalValue == data2)
            userDefaultsKeyOptionalValue = nil
            #expect(userDefaultsKeyOptionalValue == nil)
        }

        @Persisted(
            key: .customData,
            transformForGetting: {
                try! JSONDecoder().decode(CustomData.self, from: $0)
            },
            transformForSetting: {
                try! JSONEncoder().encode($0)
            }
        )
        var userDefaultsKeyCustomData = CustomData(value: 0)

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyCustomData() {
            #expect(userDefaultsKeyCustomData == CustomData(value: 0))
            userDefaultsKeyCustomData = CustomData(value: 1)
            #expect(userDefaultsKeyCustomData == CustomData(value: 1))
        }

        @Persisted(
            key: .optionalCustomData,
            transformForGetting: {
                try! JSONDecoder().decode(CustomData?.self, from: $0)
            },
            transformForSetting: {
                try! JSONEncoder().encode($0)
            }
        )
        var userDefaultsKeyOptionalCustomData: CustomData?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeyOptionalCustomData() {
            #expect(userDefaultsKeyOptionalCustomData == nil)
            userDefaultsKeyOptionalCustomData = CustomData(value: 1)
            #expect(userDefaultsKeyOptionalCustomData == CustomData(value: 1))
            userDefaultsKeyOptionalCustomData = nil
            #expect(userDefaultsKeyOptionalCustomData == nil)
        }

        // MARK: - UserDefaultsKeys

        @Persisted(key: UserDefaultsKeys.value)
        var userDefaultsKeysValue = data1

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysValue() {
            #expect(userDefaultsKeysValue == data1)
            userDefaultsKeysValue = data2
            #expect(userDefaultsKeysValue == data2)
        }

        @Persisted(key: UserDefaultsKeys.optionalValue)
        var userDefaultsKeysOptionalValue: Data?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysOptionalValue() {
            #expect(userDefaultsKeysOptionalValue == nil)
            userDefaultsKeysOptionalValue = data2
            #expect(userDefaultsKeysOptionalValue == data2)
            userDefaultsKeysOptionalValue = nil
            #expect(userDefaultsKeysOptionalValue == nil)
        }

        @Persisted(
            key: UserDefaultsKeys.customData,
            transformForGetting: {
                try! JSONDecoder().decode(CustomData.self, from: $0)
            },
            transformForSetting: {
                try! JSONEncoder().encode($0)
            }
        )
        var userDefaultsKeysCustomData = CustomData(value: 0)

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysCustomData() {
            #expect(userDefaultsKeysCustomData == CustomData(value: 0))
            userDefaultsKeysCustomData = CustomData(value: 1)
            #expect(userDefaultsKeysCustomData == CustomData(value: 1))
        }

        @Persisted(
            key: UserDefaultsKeys.optionalCustomData,
            transformForGetting: {
                try! JSONDecoder().decode(CustomData?.self, from: $0)
            },
            transformForSetting: {
                try! JSONEncoder().encode($0)
            }
        )
        var userDefaultsKeysOptionalCustomData: CustomData?

        @Test(.mockUserDefaults)
        mutating func testUserDefaultsKeysOptionalCustomData() {
            #expect(userDefaultsKeysOptionalCustomData == nil)
            userDefaultsKeysOptionalCustomData = CustomData(value: 1)
            #expect(userDefaultsKeysOptionalCustomData == CustomData(value: 1))
            userDefaultsKeysOptionalCustomData = nil
            #expect(userDefaultsKeysOptionalCustomData == nil)
        }
    }
#endif
