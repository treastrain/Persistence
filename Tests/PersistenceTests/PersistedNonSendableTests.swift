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
        key: "wrapped-value",
        transformForGetting: { $0.value },
        transformForSetting: { NonSendableValue(value: $0) }
    )
    var wrappedValue = 0

    @Test
    mutating func testWrappedValue() {
        #expect(wrappedValue == 0)
        wrappedValue = 1
        #expect(wrappedValue == 1)
    }

    @Persisted(
        store: NonSendableStorageStore(),
        key: "optional-wrapped-value",
        transformForGetting: { $0.value },
        transformForSetting: { $0.map(NonSendableValue.init(value:)) }
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
        store: NonSendableStorageStore(),
        key: "custom-notification-wrapped-value",
        notificationName: Notification.Name(
            "custom-notification-wrapped-value"
        ),
        transformForGetting: { $0.value },
        transformForSetting: { NonSendableValue(value: $0) }
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

    func getValue(forKey key: String) -> NonSendableValue? {
        storage[key]
    }

    mutating func set(value: NonSendableValue?, forKey key: String) {
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

    func getValue(forKey key: String) -> Value? {
        storage[key]
    }

    func set(value: Value?, forKey key: String) {
        storage[key] = value
    }
}
