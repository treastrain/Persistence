//
//  Persisted+Concurrency.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

#if canImport(Darwin)
    import Foundation

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    extension Persisted {
        public var values: Values {
            Values(
                NotificationCenter.default.notifications(
                    named: internalNotificationName
                )
                .map { ($0.object as! NotificationObject<Value>).value }
            )
        }
    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    extension Persisted {
        /// A type-erased asynchronous sequence for returns of values.
        public struct Values: AsyncSequence {
            public struct AsyncIterator: AsyncIteratorProtocol {
                private let next: () async -> Value?

                fileprivate init(next: @escaping () async -> Value?) {
                    self.next = next
                }

                public mutating func next() async -> Value? {
                    await next()
                }
            }

            private let base:
                AsyncMapSequence<NotificationCenter.Notifications, Value>

            fileprivate init(
                _ base: AsyncMapSequence<
                    NotificationCenter.Notifications, Value
                >
            ) {
                self.base = base
            }

            public func makeAsyncIterator() -> AsyncIterator {
                var it = base.makeAsyncIterator()
                return AsyncIterator(next: { await it.next() })
            }
        }
    }
#endif
