//
//  Persisted.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

@propertyWrapper
public struct Persisted<
    Store: KeyValuePersistentStore,
    Value: Sendable
>: Sendable {
    public var wrappedValue: Value {
        get {
            if let value = store.getValue(forKey: key) {
                transformForGetting(value) ?? defaultValue()
            } else {
                defaultValue()
            }
        }
        set {
            let value = transformForSetting(newValue)
            store.set(value: value, forKey: key)
            NotificationCenter.default.post(
                name: internalNotificationName,
                object: NotificationObject(newValue)
            )
            if let notificationName {
                NotificationCenter.default.post(
                    name: notificationName,
                    object: newValue
                )
            }
        }
    }

    #if canImport(Darwin) || canImport(Combine)
        public var projectedValue: Self { self }
    #endif

    var store: Store
    let key: String
    let notificationName: Notification.Name?
    let transformForGetting: @Sendable (sending Store.Value) -> Value?
    let transformForSetting: @Sendable (Value) -> sending Store.Value?
    let defaultValue: @Sendable () -> Value
    let internalNotificationName = Notification.Name(UUID().uuidString)
}

extension Persisted {
    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending Store,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) ->
            Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) {
        self.init(
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting,
            defaultValue: wrappedValue
        )
    }

    public init<T>(
        store: consuming sending Store,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) ->
            Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) where Value == T? {
        self.init(
            wrappedValue: nil,
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }
}

extension Persisted where Value == Store.Value {
    public init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending Store,
        key: String,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue(),
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
    }

    public init<T>(
        store: consuming sending Store,
        key: String,
        notificationName: Notification.Name? = nil
    ) where Value == T? {
        self.init(
            wrappedValue: nil,
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
    }
}
