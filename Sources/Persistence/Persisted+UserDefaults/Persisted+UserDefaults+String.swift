//
//  Persisted+UserDefaults+String.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension Persisted where Store == UserDefaultsForString {
    public init(
        store: consuming UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?,
        defaultValue: consuming Value
    ) {
        self.init(
            store: Store(store: store),
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting,
            defaultValue: defaultValue
        )
    }

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
        store: consuming UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?,
        defaultValue: consuming Value
    ) {
        self.init(
            store: Store(store: store),
            key: key.rawValue,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting,
            defaultValue: defaultValue
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

extension Persisted where Store == UserDefaultsForString, Value == Store.Value {
    public init(
        store: consuming UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil,
        defaultValue: consuming Value
    ) {
        self.init(
            store: Store(store: store),
            key: key,
            notificationName: notificationName,
            defaultValue: defaultValue
        )
    }

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
        store: consuming UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil,
        defaultValue: consuming Value
    ) {
        self.init(
            store: Store(store: store),
            key: key.rawValue,
            notificationName: notificationName,
            defaultValue: defaultValue
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

extension Persisted
where Store == UserDefaultsForString?, Value == Store.Value {
    public init(
        store: consuming UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil,
        defaultValue: consuming Value
    ) {
        self.init(
            store: Store(.init(store: store)),
            key: key,
            notificationName: notificationName,
            defaultValue: defaultValue
        )
    }

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
        store: consuming UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil,
        defaultValue: consuming Value
    ) {
        self.init(
            store: Store(.init(store: store)),
            key: key.rawValue,
            notificationName: notificationName,
            defaultValue: defaultValue
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

public struct UserDefaultsForString: UserDefaultsAdaptor {
    public nonisolated(unsafe) let store: UserDefaults

    public init(store: consuming UserDefaults) {
        self.store = store
    }

    public func getValue(forKey key: String) -> String? {
        store.string(forKey: key)
    }

    public func set(value: String?, forKey key: String) {
        store.set(value, forKey: key)
    }
}
