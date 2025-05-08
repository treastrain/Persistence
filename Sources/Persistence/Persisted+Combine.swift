//
//  Persisted+Combine.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

#if canImport(Combine)
    import Foundation
    import Combine

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    extension Persisted {
        public var publisher: some Publisher<Value, Never> {
            NotificationCenter.default.publisher(
                for: internalNotificationName
            )
            .map { ($0.object as! NotificationObject<Value>).value }
        }
    }
#endif
