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
            store: Store.shared,
            key: "value",
            defaultValue: 0
        )
        var value: Int

        @Test(.tags(.defaultValue))
        mutating func test() async {
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
            store: Store.shared,
            key: "wrapped-value"
        )
        var wrappedValue: Int = 0

        @Test(.tags(.wrappedValue))
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
            store: Store.shared,
            key: "optional-value",
            defaultValue: nil
        )
        var optionalValue: Int?

        @Test(.tags(.defaultValue))
        mutating func testOptionalValue() async {
            #expect(optionalValue == nil)
            do {
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
            }
            do {
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

        @Persisted(
            store: Store.shared,
            key: "optional-wrapped-value"
        )
        var optionalWrappedValue: Int? = nil

        @Test(.tags(.wrappedValue))
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
#endif
