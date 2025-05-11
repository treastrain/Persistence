//
//  PersistedUserDefaultsStringArrayTests+UserDefaultsKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let defaultArray = ["a", "b", "c"]
private let anotherArray = ["x", "y"]

struct PersistedUserDefaultsStringArrayUserDefaultsKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .value,
        defaultValue: defaultArray
    )
    var userDefaultsKeysValue

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeys() {
        #expect(userDefaultsKeysValue == defaultArray)
        userDefaultsKeysValue = anotherArray
        #expect(userDefaultsKeysValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .wrappedValue
    )
    var userDefaultsKeysWrappedValue = defaultArray

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysWrappedValue() {
        #expect(userDefaultsKeysWrappedValue == defaultArray)
        userDefaultsKeysWrappedValue = anotherArray
        #expect(userDefaultsKeysWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalValue,
        defaultValue: nil
    )
    var userDefaultsKeysOptionalValue: [String]?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysOptionalValue() {
        #expect(userDefaultsKeysOptionalValue == nil)
        userDefaultsKeysOptionalValue = anotherArray
        #expect(userDefaultsKeysOptionalValue == anotherArray)
        userDefaultsKeysOptionalValue = nil
        #expect(userDefaultsKeysOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalWrappedValue
    )
    var userDefaultsKeysOptionalWrappedValue: [String]? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysOptionalWrappedValue() {
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
        userDefaultsKeysOptionalWrappedValue = anotherArray
        #expect(userDefaultsKeysOptionalWrappedValue == anotherArray)
        userDefaultsKeysOptionalWrappedValue = nil
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: defaultArray
    )
    var userDefaultsKeysTransformValue

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformValue() {
        #expect(userDefaultsKeysTransformValue == defaultArray)
        userDefaultsKeysTransformValue = anotherArray
        #expect(userDefaultsKeysTransformValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformWrappedValue = defaultArray

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformWrappedValue() {
        #expect(userDefaultsKeysTransformWrappedValue == defaultArray)
        userDefaultsKeysTransformWrappedValue = anotherArray
        #expect(userDefaultsKeysTransformWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 },
        defaultValue: nil
    )
    var userDefaultsKeysTransformOptionalValue: [String]?

    @Test(.tags(.defaultValue))
    mutating func testUserDefaultsKeysTransformOptionalValue() {
        #expect(userDefaultsKeysTransformOptionalValue == nil)
        userDefaultsKeysTransformOptionalValue = anotherArray
        #expect(userDefaultsKeysTransformOptionalValue == anotherArray)
        userDefaultsKeysTransformOptionalValue = nil
        #expect(userDefaultsKeysTransformOptionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalWrappedValue: [String]? = nil

    @Test(.tags(.wrappedValue))
    mutating func testUserDefaultsKeysTransformOptionalWrappedValue() {
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
        userDefaultsKeysTransformOptionalWrappedValue = anotherArray
        #expect(userDefaultsKeysTransformOptionalWrappedValue == anotherArray)
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

extension Persisted where Store == UserDefaultsForStringArray {
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

extension Persisted
where Store == UserDefaultsForStringArray, Value == Store.Value {
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

extension Persisted
where Store == UserDefaultsForStringArray?, Value == Store.Value {
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
