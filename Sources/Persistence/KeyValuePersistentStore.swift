//
//  KeyValuePersistentStore.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

public protocol KeyValuePersistentStore: PersistentStore {
    associatedtype Value
    func getValue(forKey key: String) -> Value?
    mutating func set(value: Value?, forKey key: String)
}

extension Optional: KeyValuePersistentStore
where Wrapped: KeyValuePersistentStore {
    public func getValue(forKey key: String) -> Wrapped.Value?? {
        self?.getValue(forKey: key)
    }

    public mutating func set(value: Wrapped.Value??, forKey key: String) {
        self?.set(value: value!, forKey: key)
    }
}
