//
//  PersistedUserDefaultsDataTests+StringKey.swift
//  Persistence
//
//  Created by treastrain on 2025/05/10.
//

import Foundation
import Testing

@testable import Persistence

private let data1 = Data(repeating: 0x1, count: 16)
private let data2 = Data(repeating: 0x2, count: 16)

struct PersistedUserDefaultsDataStringKeyTests: Sendable {
    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "value"
    )
    var value = data1

    @Test
    mutating func testValue() {
        #expect(value == data1)
        value = data2
        #expect(value == data2)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value"
    )
    var optionalValue: Data? = nil

    @Test
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = data2
        #expect(optionalValue == data2)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "custom-data",
        transformForGetting: {
            try! JSONDecoder().decode(CustomData.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var wrappedCustomData = CustomData(value: 0)

    @Test
    mutating func testWrappedCustomData() {
        #expect(wrappedCustomData == CustomData(value: 0))
        wrappedCustomData = CustomData(value: 1)
        #expect(wrappedCustomData == CustomData(value: 1))
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-custom-data",
        transformForGetting: {
            try! JSONDecoder().decode(CustomData?.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var optionalWrappedCustomData: CustomData? = nil

    @Test
    mutating func testOptionalWrappedCustomData() {
        #expect(optionalWrappedCustomData == nil)
        optionalWrappedCustomData = CustomData(value: 1)
        #expect(optionalWrappedCustomData == CustomData(value: 1))
        optionalWrappedCustomData = nil
        #expect(optionalWrappedCustomData == nil)
    }
}

struct CustomData: Codable, Equatable, Sendable {
    let value: Int
}
