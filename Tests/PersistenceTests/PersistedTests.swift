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
        store: Store.shared,
        key: "value",
        defaultValue: 0
    )
    var value: Int

    @Test(.tags(.defaultValue))
    mutating func test() {
        #expect(value == 0)
        value = 1
        #expect(value == 1)
    }

    @Persisted(
        store: Store.shared,
        key: "wrapped-value"
    )
    var wrappedValue: Int = 0

    @Test(.tags(.wrappedValue))
    mutating func testWrappedValue() {
        #expect(wrappedValue == 0)
        wrappedValue = 1
        #expect(wrappedValue == 1)
    }

    @Persisted(
        store: Store.shared,
        key: "optional-value",
        defaultValue: nil
    )
    var optionalValue: Int?

    @Test(.tags(.defaultValue))
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = 1
        #expect(optionalValue == 1)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: Store.shared,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: Int? = nil

    @Test(.tags(.wrappedValue))
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = 1
        #expect(optionalWrappedValue == 1)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: Store.shared,
        key: "custom-notification-value",
        notificationName: Notification.Name("custom-notification"),
        defaultValue: 0
    )
    var customNotificationValue: Int

    @Test(.tags(.defaultValue))
    mutating func testCustomNotificationValue() async {
        let name = Notification.Name("custom-notification")
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

    @Persisted(
        store: Store.shared,
        key: "custom-notification-wrapped-value",
        notificationName: Notification.Name("custom-notification-wrapped-value")
    )
    var customNotificationWrappedValue: Int = 0

    @Test(.tags(.wrappedValue))
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

private struct Store: KeyValuePersistentStore {
    static let shared = Self()

    private var storage: [String: Data] = [:]

    func getValue(forKey key: String) -> Data? {
        storage[key]
    }

    mutating func set(value: Data?, forKey key: String) {
        storage[key] = value
    }
}
