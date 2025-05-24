//
//  UserDefaultsStorable.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

import Foundation

public protocol UserDefaultsStorable: Sendable {
    static func get(store: UserDefaults, forKey key: String) -> Self?
    static func set(store: UserDefaults, value: Self?, forKey key: String)
}

extension Optional: UserDefaultsStorable where Wrapped: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Wrapped?? {
        Wrapped.get(store: store, forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Wrapped??,
        forKey key: String
    ) {
        Wrapped.set(store: store, value: value!, forKey: key)
    }
}

// MARK: - Bool

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

// MARK: - Data

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

// MARK: - Double

extension Double: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.object(forKey: key) == nil ? nil : store.double(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        store.set(value, forKey: key)
    }
}

// MARK: - Float

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

// MARK: - Int

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

// MARK: - String

extension String: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.string(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        store.set(value, forKey: key)
    }
}

// MARK: - [String]

extension [String]: UserDefaultsStorable {
    public static func get(
        store: UserDefaults,
        forKey key: String
    ) -> Self? {
        store.stringArray(forKey: key)
    }

    public static func set(
        store: UserDefaults,
        value: Self?,
        forKey key: String
    ) {
        store.set(value, forKey: key)
    }
}

// MARK: - URL

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
