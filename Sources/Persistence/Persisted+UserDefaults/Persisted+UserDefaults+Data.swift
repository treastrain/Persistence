//
//  Persisted+UserDefaults+Data.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension Persisted where Store == UserDefaultsForData {
    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) ->
            Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) {
        self.init(
            wrappedValue: wrappedValue(),
            store: Store(store: store),
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }

    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) ->
            Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) {
        self.init(
            wrappedValue: wrappedValue(),
            store: Store(store: store),
            key: key.rawValue,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }
}

extension Persisted where Store == UserDefaultsForData, Value == Store.Value {
    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue(),
            store: Store(store: store),
            key: key,
            notificationName: notificationName
        )
    }

    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue(),
            store: Store(store: store),
            key: key.rawValue,
            notificationName: notificationName
        )
    }
}

extension Persisted where Store == UserDefaultsForData?, Value == Store.Value {
    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue(),
            store: Store(.init(store: store)),
            key: key,
            notificationName: notificationName
        )
    }

    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue(),
            store: Store(.init(store: store)),
            key: key.rawValue,
            notificationName: notificationName
        )
    }
}

public struct UserDefaultsForData: UserDefaultsAdaptor {
    public nonisolated(unsafe) let store: UserDefaults

    public init(store: consuming sending UserDefaults) {
        self.store = store
    }

    public func getValue(forKey key: String) -> sending Data? {
        store.data(forKey: key)
    }

    public func set(value: sending Data?, forKey key: String) {
        store.set(value, forKey: key)
    }
}
