//
//  KeyValuePersistentStore.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

public protocol KeyValuePersistentStore: PersistentStore {
    associatedtype Value
    func getValue(forKey key: String) -> sending Value?
    mutating func set(value: sending Value?, forKey key: String)
}

extension Optional: KeyValuePersistentStore
where Wrapped: KeyValuePersistentStore {
    public func getValue(forKey key: String) -> sending Wrapped.Value?? {
        self?.getValue(forKey: key)
    }

    public mutating func set(
        value: sending Wrapped.Value??,
        forKey key: String
    ) {
        self?.set(value: value!, forKey: key)
    }
}
