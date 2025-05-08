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
            store: Store.shared,
            key: "value",
            defaultValue: 0
        )
        var value: Int

        @Test(.tags(.defaultValue))
        mutating func test() async {
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
            store: Store.shared,
            key: "wrapped-value"
        )
        var wrappedValue: Int = 0

        @Test(.tags(.wrappedValue))
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
            store: Store.shared,
            key: "optional-value",
            defaultValue: nil
        )
        var optionalValue: Int?

        @Test(.tags(.defaultValue))
        mutating func testOptionalValue() async {
            #expect(optionalValue == nil)
            do {
                let cancellable = await confirmation { confirmation in
                    let cancellable = $optionalValue.publisher.sink { value in
                        #expect(value == 1)
                        confirmation()
                    }
                    optionalValue = 1
                    return cancellable
                }
                cancellable.cancel()
                #expect(optionalValue == 1)
            }
            do {
                let cancellable = await confirmation { confirmation in
                    let cancellable = $optionalValue.publisher.sink { value in
                        #expect(value == nil)
                        confirmation()
                    }
                    optionalValue = nil
                    return cancellable
                }
                cancellable.cancel()
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
