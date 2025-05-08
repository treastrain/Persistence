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
    Value: Codable & Sendable,
    Decoder: PersistentDecoder,
    Encoder: PersistentEncoder
>: Sendable {
    public init(
        store: Store,
        key: String,
        notificationName: Notification.Name? = nil,
        decoder: Decoder,
        encoder: Encoder,
        defaultValue: Value
    ) {
        self.store = store
        self.key = key
        self.notificationName = notificationName
        self.decoder = decoder
        self.encoder = encoder
        self.defaultValue = defaultValue
        self.internalNotificationName = Notification.Name(UUID().uuidString)
    }

    public init(
        wrappedValue: Value,
        store: Store,
        key: String,
        notificationName: Notification.Name? = nil,
        decoder: Decoder,
        encoder: Encoder
    ) {
        self.init(
            store: store,
            key: key,
            notificationName: notificationName,
            decoder: decoder,
            encoder: encoder,
            defaultValue: wrappedValue
        )
    }

    var store: Store
    let key: String
    let notificationName: Notification.Name?
    let decoder: Decoder
    let encoder: Encoder
    let defaultValue: Value
    let internalNotificationName: Notification.Name

    public var wrappedValue: Value {
        get {
            store.getValue(forKey: key)
                .flatMap { decoder.decode(Value.self, from: $0) }
                ?? defaultValue
        }
        set {
            let data = encoder.encode(newValue)
            store.set(value: data, forKey: key)
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

    public var projectedValue: Self { self }
}
