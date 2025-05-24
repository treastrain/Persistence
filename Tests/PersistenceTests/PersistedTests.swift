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
        key: "value"
    )
    var value = 0

    @Test
    mutating func testValue() {
        #expect(value == 0)
        value = 1
        #expect(value == 1)
    }

    @Persisted(
        store: Store(),
        key: "optional-value"
    )
    var optionalValue: Int?

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = 1
        #expect(optionalValue == 1)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: Store(),
        key: "custom-notification-value",
        notificationName: Notification.Name("custom-notification-value")
    )
    var customNotificationValue = 0

    @Test
    mutating func testCustomNotificationValue() async {
        let name = Notification.Name("custom-notification-value")
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
            customNotificationValue = 1
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
