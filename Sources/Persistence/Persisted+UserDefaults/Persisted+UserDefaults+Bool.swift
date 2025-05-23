//
//  Persisted+UserDefaults+Bool.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension Persisted where Store == UserDefaultsForBool {
    public init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: Store(store: store),
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }

    public init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: Store(store: store),
            key: key.rawValue,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }
}

extension Persisted where Store == UserDefaultsForBool, Value == Store.Value {
    public init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: Store(store: store),
            key: key,
            notificationName: notificationName
        )
    }

    public init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: Store(store: store),
            key: key.rawValue,
            notificationName: notificationName
        )
    }
}

extension Persisted where Store == UserDefaultsForBool?, Value == Store.Value {
    public init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: Store(.init(store: store)),
            key: key,
            notificationName: notificationName
        )
    }

    public init(
        wrappedValue: consuming Value,
        store: consuming UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: Store(.init(store: store)),
            key: key.rawValue,
            notificationName: notificationName
        )
    }
}

public struct UserDefaultsForBool: UserDefaultsAdaptor {
    public nonisolated(unsafe) let store: UserDefaults

    public init(store: consuming UserDefaults) {
        self.store = store
    }

    public func getValue(forKey key: String) -> Bool? {
        store.object(forKey: key) == nil ? nil : store.bool(forKey: key)
    }

    public func set(value: Bool?, forKey key: String) {
        store.set(value, forKey: key)
    }
}
