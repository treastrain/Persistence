//
//  UserDefaults+.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

extension Persisted where Store == UserDefaults {
    public init<Key: UserDefaultsKey>(
        store: UserDefaults = .standard,
        key: Key,
        notificationName: Notification.Name? = nil,
        decoder: Decoder,
        encoder: Encoder,
        defaultValue: Value
    ) {
        self.init(
            store: store,
            key: key.rawValue,
            notificationName: notificationName,
            decoder: decoder,
            encoder: encoder,
            defaultValue: defaultValue
        )
    }

    public init<Key: UserDefaultsKey>(
        wrappedValue: Value,
        store: UserDefaults = .standard,
        key: Key,
        notificationName: Notification.Name? = nil,
        decoder: Decoder,
        encoder: Encoder
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: store,
            key: key.rawValue,
            notificationName: notificationName,
            decoder: decoder,
            encoder: encoder
        )
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Persisted
where Store == UserDefaults, Decoder == JSONDecoder, Encoder == JSONEncoder {
    public init<Key: UserDefaultsKey>(
        store: UserDefaults = .standard,
        key: Key,
        notificationName: Notification.Name? = nil,
        defaultValue: Value
    ) {
        self.init(
            store: store,
            key: key,
            notificationName: notificationName,
            decoder: JSONDecoder(),
            encoder: JSONEncoder(),
            defaultValue: defaultValue
        )
    }

    public init<Key: UserDefaultsKey>(
        wrappedValue: Value,
        store: UserDefaults = .standard,
        key: Key,
        notificationName: Notification.Name? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            store: store,
            key: key,
            notificationName: notificationName,
            decoder: JSONDecoder(),
            encoder: JSONEncoder()
        )
    }
}

public protocol UserDefaultsKey: RawRepresentable<String>, Sendable {}

extension UserDefaults: KeyValuePersistentStore {
    public func getValue(forKey key: String) -> Data? {
        data(forKey: key)
    }

    public func set(value: Data?, forKey key: String) {
        set(value, forKey: key)
    }
}

extension UserDefaults: @retroactive @unchecked Sendable {}
