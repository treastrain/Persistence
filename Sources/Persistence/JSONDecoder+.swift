//
//  JSONDecoder+.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension JSONDecoder: PersistentDecoder {
    @_disfavoredOverload
    public func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        try? decode(type, from: data)
    }
}
