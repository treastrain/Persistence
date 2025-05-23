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
        key: .wrappedValue
    )
    var userDefaultsKeysWrappedValue = data1

    @Test
    mutating func testUserDefaultsKeysWrappedValue() {
        #expect(userDefaultsKeysWrappedValue == data1)
        userDefaultsKeysWrappedValue = data2
        #expect(userDefaultsKeysWrappedValue == data2)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalWrappedValue
    )
    var userDefaultsKeysOptionalWrappedValue: Data? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalWrappedValue() {
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
        userDefaultsKeysOptionalWrappedValue = data2
        #expect(userDefaultsKeysOptionalWrappedValue == data2)
        userDefaultsKeysOptionalWrappedValue = nil
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .wrappedCustomData,
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
        key: .optionalWrappedCustomData,
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

private enum UserDefaultsKeys: String, UserDefaultsKey {
    case wrappedValue
    case optionalWrappedValue
    case wrappedCustomData
    case optionalWrappedCustomData
}

extension Persisted where Store == UserDefaultsForData {
    fileprivate init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue(),
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }
}

extension Persisted where Store == UserDefaultsForData, Value == Store.Value {
    fileprivate init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue(),
            store: store,
            key: key,
            notificationName: notificationName
        )
    }
}

extension Persisted where Store == UserDefaultsForData?, Value == Store.Value {
    fileprivate init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue(),
            store: store,
            key: key,
            notificationName: notificationName
        )
    }
}
