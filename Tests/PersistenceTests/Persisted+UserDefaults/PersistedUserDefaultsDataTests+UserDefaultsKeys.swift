//
//  PersistedUserDefaultsDataTests+UserDefaultsKeys.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let data1 = Data(repeating: 0x1, count: 16)
private let data2 = Data(repeating: 0x2, count: 16)

struct PersistedUserDefaultsDataUserDefaultsKeysTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.value,
        defaultValue: data1
    )
    var userDefaultsKeysValue

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeys() {
        #expect(userDefaultsKeysValue == data1)
        userDefaultsKeysValue = data2
        #expect(userDefaultsKeysValue == data2)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.wrappedValue
    )
    var userDefaultsKeysWrappedValue = data1

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysWrappedValue() {
        #expect(userDefaultsKeysWrappedValue == data1)
        userDefaultsKeysWrappedValue = data2
        #expect(userDefaultsKeysWrappedValue == data2)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalValue,
        defaultValue: nil
    )
    var userDefaultsKeysOptionalValue: Data?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = data2
        #expect(userDefaultsKeysOptionalValue == data2)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalWrappedValue
    )
    var userDefaultsKeysOptionalWrappedValue: Data? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysOptionalWrappedValue() {
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
        userDefaultsKeysOptionalWrappedValue = data2
        #expect(userDefaultsKeysOptionalWrappedValue == data2)
        userDefaultsKeysOptionalWrappedValue = nil
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.customData,
        transformForGetting: {
            try! JSONDecoder().decode(CustomData.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        },
        defaultValue: CustomData(value: 0)
    )
    var userDefaultsKeysCustomData: CustomData

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysCustomData() {
        #expect(userDefaultsKeysCustomData == CustomData(value: 0))
        userDefaultsKeysCustomData = CustomData(value: 1)
        #expect(userDefaultsKeysCustomData == CustomData(value: 1))
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.wrappedCustomData,
        transformForGetting: {
            try! JSONDecoder().decode(CustomData.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var userDefaultsKeysWrappedCustomData = CustomData(value: 0)

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysWrappedCustomData() {
        #expect(userDefaultsKeysWrappedCustomData == CustomData(value: 0))
        userDefaultsKeysWrappedCustomData = CustomData(value: 1)
        #expect(userDefaultsKeysWrappedCustomData == CustomData(value: 1))
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalCustomData,
        transformForGetting: {
            try! JSONDecoder().decode(CustomData?.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        },
        defaultValue: nil
    )
    var userDefaultsKeysOptionalCustomData: CustomData?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysOptionalCustomData() {
        #expect(userDefaultsKeysOptionalCustomData == nil)
        userDefaultsKeysOptionalCustomData = CustomData(value: 1)
        #expect(userDefaultsKeysOptionalCustomData == CustomData(value: 1))
        userDefaultsKeysOptionalCustomData = nil
        #expect(userDefaultsKeysOptionalCustomData == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: UserDefaultsKeys.optionalWrappedCustomData,
        transformForGetting: {
            try! JSONDecoder().decode(CustomData?.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var userDefaultsKeysOptionalWrappedCustomData: CustomData? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysOptionalWrappedCustomData() {
        #expect(userDefaultsKeysOptionalWrappedCustomData == nil)
        userDefaultsKeysOptionalWrappedCustomData = CustomData(value: 1)
        #expect(
            userDefaultsKeysOptionalWrappedCustomData == CustomData(value: 1)
        )
        userDefaultsKeysOptionalWrappedCustomData = nil
        #expect(userDefaultsKeysOptionalWrappedCustomData == nil)
    }
}

private enum UserDefaultsKeys: String, UserDefaultsKey {
    case value
    case wrappedValue
    case optionalValue
    case optionalWrappedValue
    case customData
    case wrappedCustomData
    case optionalCustomData
    case optionalWrappedCustomData
}
