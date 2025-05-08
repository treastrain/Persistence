//
//  NotificationObject.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

struct NotificationObject<Value: Sendable>: Sendable {
    let value: Value

    init(_ value: Value) {
        self.value = value
    }
}
