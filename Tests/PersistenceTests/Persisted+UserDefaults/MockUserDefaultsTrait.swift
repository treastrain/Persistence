//
//  MockUserDefaultsTrait.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

import Foundation
import Persistence
import Testing

struct MockUserDefaultsTrait: TestTrait {}

extension Trait where Self == MockUserDefaultsTrait {
    static var mockUserDefaults: Self { Self() }
}

#if swift(>=6.1)
    extension MockUserDefaultsTrait: TestScoping {
        func provideScope(
            for test: Test,
            testCase: Test.Case?,
            performing function: @Sendable () async throws -> Void
        ) async throws {
            let mockUserDefaults = UserDefaults(suiteName: UUID().uuidString)!
            try await UserDefaultsRepresentation.$current.withValue(
                mockUserDefaults,
                operation: function
            )
        }
    }
#endif
