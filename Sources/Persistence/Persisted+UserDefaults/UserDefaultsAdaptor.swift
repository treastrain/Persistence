//
//  UserDefaultsAdaptor.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

import Foundation

public struct UserDefaultsAdaptor<
    T: UserDefaultsStorable
>: KeyValuePersistentStore, Sendable {
    public init(store: consuming sending UserDefaults) {
        self.store =
            if #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *),
                let current = UserDefaultsRepresentation.current
            {
                current
            } else {
                UserDefaultsRepresentation(store)
            }
    }

    public func getValue(forKey key: String) -> sending T? {
        T.get(store: store.base, forKey: key)
    }

    public mutating func set(value: sending T?, forKey key: String) {
        T.set(store: store.base, value: value, forKey: key)
    }

    private let store: UserDefaultsRepresentation
}
