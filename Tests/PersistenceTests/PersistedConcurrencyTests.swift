//
//  PersistedConcurrencyTests.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

#if canImport(Darwin)
    import Foundation
    import Testing

    @testable import Persistence

    struct PersistedConcurrencyTests: Sendable {
        @Persisted(
            store: Store(),
            key: "wrapped-value"
        )
        var wrappedValue = 0

        @Test
        mutating func testWrappedValue() async {
            #expect(wrappedValue == 0)
            await confirmation { confirmation in
                let values = $wrappedValue.values
                wrappedValue = 1
                for await value in values {
                    #expect(value == 1)
                    confirmation()
                    break
                }
            }
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
            await confirmation { confirmation in
                let values = $optionalWrappedValue.values
                optionalWrappedValue = 1
                for await value in values {
                    #expect(value == 1)
                    confirmation()
                    break
                }
            }
            #expect(optionalWrappedValue == 1)
            await confirmation { confirmation in
                let values = $optionalWrappedValue.values
                optionalWrappedValue = nil
                for await value in values {
                    #expect(value == nil)
                    confirmation()
                    break
                }
            }
            #expect(optionalWrappedValue == nil)
        }
    }

    private struct Store<Value: Codable & Sendable>: KeyValuePersistentStore {
        private var storage: [String: Value] = [:]

        func getValue(forKey key: String) -> Value? {
            storage[key]
        }

        mutating func set(value: Value?, forKey key: String) {
            storage[key] = value
        }
    }
#endif
