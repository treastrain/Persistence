//
//  PersistedUserDefaultsBoolTests+UserDefaultsKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedUserDefaultsBoolUserDefaultsKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .value,
        defaultValue: false
    )
    var userDefaultsKeysValue

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeys() {
        #expect(userDefaultsKeysValue == false)
        userDefaultsKeysValue = true
        #expect(userDefaultsKeysValue == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .wrappedValue
    )
    var userDefaultsKeysWrappedValue = false

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysWrappedValue() {
        #expect(userDefaultsKeysWrappedValue == false)
        userDefaultsKeysWrappedValue = true
        #expect(userDefaultsKeysWrappedValue == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalValue,
        defaultValue: nil
    )
    var userDefaultsKeysOptionalValue: Bool?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = true
        #expect(userDefaultsKeysOptionalValue == true)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalWrappedValue
    )
    var userDefaultsKeysOptionalWrappedValue: Bool? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysOptionalWrappedValue() {
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
        userDefaultsKeysOptionalWrappedValue = true
        #expect(userDefaultsKeysOptionalWrappedValue == true)
        userDefaultsKeysOptionalWrappedValue = nil
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: false
    )
    var userDefaultsKeysTransformValue

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == false)
        userDefaultsKeysTransformValue = true
        #expect(userDefaultsKeysTransformValue == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformWrappedValue = false

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformWrappedValue() {
        #expect(userDefaultsKeysTransformWrappedValue == false)
        userDefaultsKeysTransformWrappedValue = true
        #expect(userDefaultsKeysTransformWrappedValue == true)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var userDefaultsKeysTransformOptionalValue: Bool?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = true
        #expect(userDefaultsKeysTransformOptionalValue == true)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalWrappedValue: Bool? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformOptionalWrappedValue() {
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
        userDefaultsKeysTransformOptionalWrappedValue = true
        #expect(userDefaultsKeysTransformOptionalWrappedValue == true)
        userDefaultsKeysTransformOptionalWrappedValue = nil
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
    }
}

private enum UserDefaultsKeys: String, UserDefaultsKey {
    case value
    case wrappedValue
    case optionalValue
    case optionalWrappedValue
    case transformValue
    case transformWrappedValue
    case transformOptionalValue
    case transformOptionalWrappedValue
}

extension Persisted where Store == UserDefaultsForBool {
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

extension Persisted where Store == UserDefaultsForBool, Value == Store.Value {
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

extension Persisted where Store == UserDefaultsForBool?, Value == Store.Value {
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
