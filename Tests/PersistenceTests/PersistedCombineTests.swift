//
//  PersistedCombineTests.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

#if canImport(Combine)
    import Combine
    import Foundation
    import Testing

    @testable import Persistence

    struct PersistedCombineTests: Sendable {
        @Persisted(
            store: Store(),
            key: "value"
        )
        var value = 0

        @Test
        mutating func testValue() async {
            #expect(value == 0)
            let cancellable = await confirmation { confirmation in
                let cancellable = $value.publisher.sink { value in
                    #expect(value == 1)
                    confirmation()
                }
                value = 1
                return cancellable
            }
            cancellable.cancel()
            #expect(value == 1)
        }

        @Persisted(
            store: Store(),
            key: "optional-value"
        )
        var optionalValue: Int?

        @Test
        mutating func testOptionalValue() async {
            #expect(optionalValue == nil)
            let cancellable = await confirmation { confirmation in
                let cancellable = $optionalValue.publisher.sink {
                    value in
                    #expect(value == 1)
                    confirmation()
                }
                optionalValue = 1
                return cancellable
            }
            cancellable.cancel()
            #expect(optionalValue == 1)
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
#endif
