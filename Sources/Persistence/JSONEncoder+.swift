//
//  JSONEncoder+.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension JSONEncoder: PersistentEncoder {
    @_disfavoredOverload
    public func encode<T: Encodable>(_ value: T) -> Data {
        try! encode(value)
    }
}
