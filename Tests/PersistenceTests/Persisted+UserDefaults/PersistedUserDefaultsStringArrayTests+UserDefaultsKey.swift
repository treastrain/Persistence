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
        key: .wrappedValue
    )
    var userDefaultsKeysWrappedValue = defaultArray

    @Test
    mutating func testUserDefaultsKeysWrappedValue() {
        #expect(userDefaultsKeysWrappedValue == defaultArray)
        userDefaultsKeysWrappedValue = anotherArray
        #expect(userDefaultsKeysWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .optionalWrappedValue
    )
    var userDefaultsKeysOptionalWrappedValue: [String]? = nil

    @Test
    mutating func testUserDefaultsKeysOptionalWrappedValue() {
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
        userDefaultsKeysOptionalWrappedValue = anotherArray
        #expect(userDefaultsKeysOptionalWrappedValue == anotherArray)
        userDefaultsKeysOptionalWrappedValue = nil
        #expect(userDefaultsKeysOptionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformWrappedValue = defaultArray

    @Test
    mutating func testUserDefaultsKeysTransformWrappedValue() {
        #expect(userDefaultsKeysTransformWrappedValue == defaultArray)
        userDefaultsKeysTransformWrappedValue = anotherArray
        #expect(userDefaultsKeysTransformWrappedValue == anotherArray)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: .transformOptionalWrappedValue,
        transformForGetting: { $0 },
        transformForSetting: { $0 }
    )
    var userDefaultsKeysTransformOptionalWrappedValue: [String]? = nil

    @Test
    mutating func testUserDefaultsKeysTransformOptionalWrappedValue() {
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
        userDefaultsKeysTransformOptionalWrappedValue = anotherArray
        #expect(userDefaultsKeysTransformOptionalWrappedValue == anotherArray)
        userDefaultsKeysTransformOptionalWrappedValue = nil
        #expect(userDefaultsKeysTransformOptionalWrappedValue == nil)
    }
}

private enum UserDefaultsKeys: String, UserDefaultsKey {
    case wrappedValue
    case optionalWrappedValue
    case transformWrappedValue
    case transformOptionalWrappedValue
}

extension Persisted where Store == UserDefaultsForStringArray {
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

extension Persisted
where Store == UserDefaultsForStringArray, Value == Store.Value {
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

extension Persisted
where Store == UserDefaultsForStringArray?, Value == Store.Value {
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
