//
//  Persisted+UserDefaults+Data.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension Data: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.data(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        store.set(value, forKey: key)
    }
}
