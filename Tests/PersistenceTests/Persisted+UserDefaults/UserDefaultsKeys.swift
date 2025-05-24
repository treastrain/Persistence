//
//  UserDefaultsKeys.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

import Foundation
import Persistence

enum UserDefaultsKeys: String, UserDefaultsKey {
    case value
    case optionalValue
    case transformValue
    case transformOptionalValue
    case customData
    case optionalCustomData
}

extension Persisted {
    init<T>(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil,
        transformForGetting: @escaping @Sendable (sending Store.Value) ->
            Value?,
        transformForSetting: @escaping @Sendable (Value) -> sending Store.Value?
    ) where Store == UserDefaultsAdaptor<T> {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue(),
            store: store,
            key: key,
            notificationName: notificationName,
            transformForGetting: transformForGetting,
            transformForSetting: transformForSetting
        )
    }
}

extension Persisted where Store == UserDefaultsAdaptor<Value> {
    init(
        wrappedValue: @autoclosure @escaping @Sendable () -> sending Value,
        store: consuming sending UserDefaults = .standard,
        key: UserDefaultsKeys,
        notificationName: Notification.Name? = nil
    ) {
        let key: some UserDefaultsKey = key
        self.init(
            wrappedValue: wrappedValue(),
            store: store,
            key: key,
            notificationName: notificationName
        )
    }
}
