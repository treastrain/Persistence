//
//  PersistedUserDefaultsDataTests+UserDefaultsKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let data1 = Data(repeating: 0x1, count: 16)
private let data2 = Data(repeating: 0x2, count: 16)

struct PersistedUserDefaultsDataUserDefaultsKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .value
    )
    var userDefaultsKeysValue = data1

    @Test
    mutating func testUserDefaultsKeysValue() {
        #expect(userDefaultsKeysValue == data1)
        userDefaultsKeysValue = data2
        #expect(userDefaultsKeysValue == data2)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalValue
    )
    var userDefaultsKeysOptionalValue: Data? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = data2
        #expect(userDefaultsKeysOptionalValue == data2)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .customData,
        transformForGetting: {
            try! JSONDecoder().decode(CustomData.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var userDefaultsKeysWrappedCustomData = CustomData(value: 0)

    @Test
    mutating func testUserDefaultsKeysWrappedCustomData() {
        #expect(userDefaultsKeysWrappedCustomData == CustomData(value: 0))
        userDefaultsKeysWrappedCustomData = CustomData(value: 1)
        #expect(userDefaultsKeysWrappedCustomData == CustomData(value: 1))
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalCustomData,
        transformForGetting: {
            try! JSONDecoder().decode(CustomData?.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var userDefaultsKeysOptionalWrappedCustomData: CustomData? = nil

    @Test
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
