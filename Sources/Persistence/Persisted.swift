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
>: Sendable where Store: Sendable {
    public init(
        store: Store,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?,
        defaultValue: consuming Value
    ) {
        self.store = store
        self.key = key
        self.notificationName = notificationName
        self.transformForGetting = transformForGetting
        self.transformForSetting = transformForSetting
        self.defaultValue = defaultValue
        self.internalNotificationName = Notification.Name(UUID().uuidString)
    }

    public init(
        wrappedValue: consuming Value,
        store: Store,
        key: String,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (Store.Value) -> Value?,
        transformForSetting: @escaping @Sendable (Value) -> Store.Value?
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

    var store: Store
    let key: String
    let notificationName: Notification.Name?
    let transformForGetting: @Sendable (Store.Value) -> Value?
    let transformForSetting: @Sendable (Value) -> Store.Value?
    let defaultValue: Value
    let internalNotificationName: Notification.Name

    public var wrappedValue: Value {
        get {
            if let value = store.getValue(forKey: key) {
                transformForGetting(value) ?? defaultValue
            } else {
                defaultValue
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
}

extension Persisted where Value == Store.Value {
    public init(
        store: Store,
        key: String,
        notificationName: Notification.Name? = nil,
        defaultValue: consuming Value
    ) {
        self.init(
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: { $0 },
            transformForSetting: { $0 },
            defaultValue: defaultValue
        )
    }

    public init(
        wrappedValue: consuming Value,
        store: Store,
        key: String,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: { $0 },
            transformForSetting: { $0 }
        )
    }
}
