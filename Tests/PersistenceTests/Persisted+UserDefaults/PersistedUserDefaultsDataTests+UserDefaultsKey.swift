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
        key: .value,
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
        key: .wrappedValue
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
        key: .optionalValue,
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
        key: .optionalWrappedValue
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
        key: .customData,
        transformForGetting: {
            try! JSONDecoder().decode(CustomData.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        },
        defaultValue: CustomData(value: 0)
    )
    var userDefaultsKeysCustomData

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysCustomData() {
        #expect(userDefaultsKeysCustomData == CustomData(value: 0))
        userDefaultsKeysCustomData = CustomData(value: 1)
        #expect(userDefaultsKeysCustomData == CustomData(value: 1))
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

    @Test(.tags(.wrappedValue))
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
        key: .optionalWrappedCustomData,
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

extension Persisted where Store == UserDefaultsForData {
    fileprivate init(
        store: consuming UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?,
        defaultValue: consuming Value
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting,
            defaultValue: defaultValue
        )
    }

    fileprivate init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue,
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
        store: consuming UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil,
        defaultValue: consuming Value
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            store: store,
            key: key,
            notificationName: notificationName,
            defaultValue: defaultValue
        )
    }

    fileprivate init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue,
            store: store,
            key: key,
            notificationName: notificationName
        )
    }
}

extension Persisted where Store == UserDefaultsForData?, Value == Store.Value {
    fileprivate init(
        store: consuming UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil,
        defaultValue: consuming Value
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            store: store,
            key: key,
            notificationName: notificationName,
            defaultValue: defaultValue
        )
    }

    fileprivate init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue,
            store: store,
            key: key,
            notificationName: notificationName
        )
    }
}
