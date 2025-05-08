//
//  KeyValuePersistentStore.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

public protocol KeyValuePersistentStore: PersistentStore {
    func getValue(forKey key: String) -> Data?
    mutating func set(value: Data?, forKey key: String)
}
