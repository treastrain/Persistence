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
