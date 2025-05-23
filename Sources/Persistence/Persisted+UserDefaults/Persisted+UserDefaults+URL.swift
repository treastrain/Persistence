//
//  Persisted+UserDefaults+URL.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation

extension URL: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.url(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        #if canImport(Darwin)
            store.set(value, forKey: key)
        #else
            // To prevent a potential freeze when setting `_value: URL?` to `nil` on non-Darwin platforms, the following workaround is used.
            if let value {
                store.set(value, forKey: key)
            } else {
                store.removeObject(forKey: key)
            }
        #endif
    }
}
