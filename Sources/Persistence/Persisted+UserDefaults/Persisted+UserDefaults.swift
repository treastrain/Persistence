//
//  Persisted+UserDefaults.swift
//  Persistence
//
//  Created by treastrain on 2025/05/08.
//

import Foundation

public protocol UserDefaultsAdaptor: KeyValuePersistentStore, Sendable {
    var store: UserDefaults { get }
    init(store: consuming UserDefaults)
}

public protocol UserDefaultsKey: RawRepresentable<String>, Sendable {}
