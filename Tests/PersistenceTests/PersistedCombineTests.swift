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
            key: "wrapped-value"
        )
        var wrappedValue = 0

        @Test
        mutating func testWrappedValue() async {
            #expect(wrappedValue == 0)
            let cancellable = await confirmation { confirmation in
                let cancellable = $wrappedValue.publisher.sink { value in
                    #expect(value == 1)
                    confirmation()
                }
                wrappedValue = 1
                return cancellable
            }
            cancellable.cancel()
            #expect(wrappedValue == 1)
        }

        @Persisted(
            store: Store(),
            key: "optional-wrapped-value"
        )
        var optionalWrappedValue: Int? = nil

        @Test
        mutating func testOptionalWrappedValue() async {
            #expect(optionalWrappedValue == nil)
            let cancellable = await confirmation { confirmation in
                let cancellable = $optionalWrappedValue.publisher.sink {
                    value in
                    #expect(value == 1)
                    confirmation()
                }
                optionalWrappedValue = 1
                return cancellable
            }
            cancellable.cancel()
            #expect(optionalWrappedValue == 1)
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
