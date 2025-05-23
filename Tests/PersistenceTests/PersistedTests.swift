//
//  PersistedTests.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedTests: Sendable {
    @Persisted(
        store: Store(),
        key: "wrapped-value"
    )
    var wrappedValue = 0

    @Test
    mutating func testWrappedValue() {
        #expect(wrappedValue == 0)
        wrappedValue = 1
        #expect(wrappedValue == 1)
    }

    @Persisted(
        store: Store(),
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: Int? = nil

    @Test
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = 1
        #expect(optionalWrappedValue == 1)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: Store(),
        key: "custom-notification-wrapped-value",
        notificationName: Notification.Name("custom-notification-wrapped-value")
    )
    var customNotificationWrappedValue = 0

    @Test
    mutating func testCustomNotificationWrappedValue() async {
        let name = Notification.Name("custom-notification-wrapped-value")
        await confirmation { confirmation in
            _ = NotificationCenter.default.addObserver(
                forName: name,
                object: nil,
                queue: nil,
                using: { notification in
                    let value = notification.object as! Int
                    #expect(value == 1)
                    confirmation()
                }
            )
            customNotificationWrappedValue = 1
        }
    }
}

private struct Store<Value: Sendable>: KeyValuePersistentStore {
    private var storage: [String: Value] = [:]

    func getValue(forKey key: String) -> sending Value? {
        storage[key]
    }

    mutating func set(value: sending Value?, forKey key: String) {
        storage[key] = value
    }
}
