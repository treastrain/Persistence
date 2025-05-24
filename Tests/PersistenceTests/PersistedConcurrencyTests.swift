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
            key: "value"
        )
        var value = 0

        @Test
        mutating func testValue() async {
            #expect(value == 0)
            await confirmation { confirmation in
                let values = $value.values
                value = 1
                for await value in values {
                    #expect(value == 1)
                    confirmation()
                    break
                }
            }
            #expect(value == 1)
        }

        @Persisted(
            store: Store(),
            key: "optional-value"
        )
        var optionalValue: Int? = nil

        @Test
        mutating func testOptionalValue() async {
            #expect(optionalValue == nil)
            await confirmation { confirmation in
                let values = $optionalValue.values
                optionalValue = 1
                for await value in values {
                    #expect(value == 1)
                    confirmation()
                    break
                }
            }
            #expect(optionalValue == 1)
            await confirmation { confirmation in
                let values = $optionalValue.values
                optionalValue = nil
                for await value in values {
                    #expect(value == nil)
                    confirmation()
                    break
                }
            }
            #expect(optionalValue == nil)
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
