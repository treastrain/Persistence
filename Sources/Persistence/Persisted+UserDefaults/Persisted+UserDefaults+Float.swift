//
//  Persisted+UserDefaults+Float.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension Float: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.object(forKey: key) == nil ? nil : store.float(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        store.set(value, forKey: key)
    }
}
