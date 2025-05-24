//
//  PersistedNonSendableTests.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

struct PersistedNonSendableTests {
    @Persisted(
        store: NonSendableStorageStore(),
        key: "value",
        transformForGetting: { $0.value },
        transformForSetting: { NonSendableValue(value: $0) }
    )
    var value = 0

    @Test
    mutating func testValue() {
        #expect(value == 0)
        value = 1
        #expect(value == 1)
    }

    @Persisted(
        store: NonSendableStorageStore(),
        key: "optional-value",
        transformForGetting: { $0.value },
        transformForSetting: { $0.map(NonSendableValue.init(value:)) }
    )
    var optionalValue: Int? = nil

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = 1
        #expect(optionalValue == 1)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: NonSendableStorageStore(),
        key: "custom-notification-value",
        notificationName: Notification.Name(
            "custom-notification-value"
        ),
        transformForGetting: { $0.value },
        transformForSetting: { NonSendableValue(value: $0) }
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

    private static let transformFailedStore = Store<String>()
    static let transformFailedValueKey = "transform-failed-value"
    @Persisted(
        store: transformFailedStore,
        key: transformFailedValueKey,
        transformForGetting: { Int($0) },
        transformForSetting: { "\($0)" }
    )
    var transformFailedValue = 999

    @Test
    mutating func testTransformFailedValue() {
        #expect(transformFailedValue == 999)
        transformFailedValue = 1
        #expect(transformFailedValue == 1)

        @Persisted(
            store: Self.transformFailedStore,
            key: Self.transformFailedValueKey
        )
        var injection = ""
        injection = "Injected"

        #expect(transformFailedValue == 999)
    }
}

@available(*, unavailable)
extension PersistedNonSendableTests: Sendable {}

private struct NonSendableStorageStore: KeyValuePersistentStore, Sendable {
    private nonisolated(unsafe) var storage: [String: NonSendableValue] = [:]

    func getValue(forKey key: String) -> sending NonSendableValue? {
        storage[key]
    }

    mutating func set(value: sending NonSendableValue?, forKey key: String) {
        storage[key] = value
    }
}

private struct NonSendableValue {
    var value: Int
}

@available(*, unavailable)
extension NonSendableValue: Sendable {}

private class Store<Value: Sendable>: KeyValuePersistentStore, @unchecked
    Sendable
{
    private var storage: [String: Value] = [:]

    func getValue(forKey key: String) -> sending Value? {
        storage[key]
    }

    func set(value: sending Value?, forKey key: String) {
        storage[key] = value
    }
}
