//
//  Persisted+UserDefaults+Int.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension Int: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.object(forKey: key) == nil ? nil : store.integer(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        store.set(value, forKey: key)
    }
}
