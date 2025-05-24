//
//  UserDefaultsRepresentationTests+TaskLocal.swift
//  Persistence
//
//  Created by treastrain on 2025/05/25.
//

import Foundation
import Testing

@testable import Persistence

struct UserDefaultsRepresentationTaskLocalTests: Sendable {
    @Test
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func asyncOperation() async {
        #expect(UserDefaultsRepresentation.current == nil)
        nonisolated(unsafe) let userDefaults = UserDefaults(suiteName: UUID().uuidString)!
        await UserDefaultsRepresentation.$current.withValue(userDefaults) {
            await Task.yield()  // dummy async operation
            #expect(UserDefaultsRepresentation.current?.base == userDefaults)
        }
    }

    @Test
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func syncOperation() {
        #expect(UserDefaultsRepresentation.current == nil)
        nonisolated(unsafe) let userDefaults = UserDefaults(suiteName: UUID().uuidString)!
        UserDefaultsRepresentation.$current.withValue(userDefaults) {
            #expect(UserDefaultsRepresentation.current?.base == userDefaults)
        }
    }
}
