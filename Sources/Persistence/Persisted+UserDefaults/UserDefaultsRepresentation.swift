//
//  UserDefaultsRepresentation.swift
//  Persistence
//
//  Created by treastrain on 2025/05/24.
//

import Foundation

public struct UserDefaultsRepresentation: Sendable {
    public init(_ base: consuming sending UserDefaults) {
        self.base = base
    }

    nonisolated(unsafe) let base: UserDefaults
}

extension UserDefaultsRepresentation {
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @TaskLocal
    public static var current: UserDefaultsRepresentation?
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension TaskLocal where Value == UserDefaultsRepresentation? {
    @discardableResult
    @inlinable final public func withValue<R>(
        _ userDefaultsDuringOperation: consuming sending UserDefaults,
        operation: () async throws -> R,
        isolation: isolated (any Actor)? = #isolation,
        file: String = #fileID,
        line: UInt = #line
    ) async rethrows -> R {
        try await withValue(
            UserDefaultsRepresentation(userDefaultsDuringOperation),
            operation: operation,
            isolation: isolation,
            file: file,
            line: line
        )
    }

    @discardableResult
    @inlinable final public func withValue<R>(
        _ userDefaultsDuringOperation: consuming sending UserDefaults,
        operation: () throws -> R,
        file: String = #fileID,
        line: UInt = #line
    ) rethrows -> R {
        try withValue(
            UserDefaultsRepresentation(userDefaultsDuringOperation),
            operation: operation,
            file: file,
            line: line
        )
    }
}
