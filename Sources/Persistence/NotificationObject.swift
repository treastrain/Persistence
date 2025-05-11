//
//  NotificationObject.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

struct NotificationObject<Value: ~Copyable> {
    let value: Value

    init(_ value: consuming Value) {
        self.value = value
    }
}

extension NotificationObject: Copyable where Value: Copyable {}
extension NotificationObject: Sendable where Value: Sendable & ~Copyable {}
extension NotificationObject: Equatable where Value: Equatable {}
extension NotificationObject: Hashable where Value: Hashable {}
