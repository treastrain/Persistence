//
//  Persisted+UserDefaults.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

// MARK: - Key Representable

public protocol UserDefaultsKey: RawRepresentable<String>, Sendable {}

// MARK: - Persisted Extensions

extension Persisted {
    public init<T>(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) ->
            Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) where Store == UserDefaultsAdaptor<T> {
        self.init(
            wrappedValue: wrappedValue(),
            store: Store(store: store),
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }

    public init<T>(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: some UserDefaultsKey,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) ->
            Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) where Store == UserDefaultsAdaptor<T> {
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

extension Persisted
where Store == UserDefaultsAdaptor<Value>, Value == Store.Value {
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

// MARK: - Adaptor

public struct UserDefaultsAdaptor<
    T: UserDefaultsStorable
>: KeyValuePersistentStore, Sendable {
    public init(store: consuming sending UserDefaults) {
        self.store = store
    }

    public func getValue(forKey key: String) -> sending T? {
        T.get(store: store, forKey: key)
    }

    public mutating func set(value: sending T?, forKey key: String) {
        T.set(store: store, value: value, forKey: key)
    }

    private nonisolated(unsafe) let store: UserDefaults
}

// MARK: - UserDefaults Storable

public protocol UserDefaultsStorable: Sendable {
    static func get(store: UserDefaults, forKey key: String) -> Self?
    static func set(store: UserDefaults, value: Self?, forKey key: String)
}

extension Optional: UserDefaultsStorable where Wrapped: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Wrapped?? {
        Wrapped.get(store: store, forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Wrapped??,
        forKey key: String
    ) {
        Wrapped.set(store: store, value: value!, forKey: key)
    }
}
