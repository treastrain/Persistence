//
//  PersistentEncoder.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

public protocol PersistentEncoder: Sendable {
    func encode<T: Encodable>(_ value: T) -> Data
}
