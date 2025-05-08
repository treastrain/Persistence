//
//  PersistentDecoder.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

public protocol PersistentDecoder: Sendable {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T?
}
