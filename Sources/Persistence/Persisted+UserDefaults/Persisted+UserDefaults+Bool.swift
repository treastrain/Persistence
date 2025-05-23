//
//  Persisted+UserDefaults+Bool.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension Bool: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.object(forKey: key) == nil ? nil : store.bool(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        store.set(value, forKey: key)
    }
}
