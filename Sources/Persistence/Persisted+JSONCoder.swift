//
//  Persisted+JSONCoder.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Persisted where Decoder == JSONDecoder, Encoder == JSONEncoder {
    public init(
        store: Store,
        key: String,
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
    
    public init(
        wrappedValue: Value,
        store: Store,
        key: String,
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
