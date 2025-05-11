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
        key: "value",
        defaultValue: data1
    )
    var value

    @Test(.tags(.defaultValue))
    mutating func test() {
        #expect(value == data1)
        value = data2
        #expect(value == data2)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "wrapped-value"
    )
    var wrappedValue = data1

    @Test(.tags(.wrappedValue))
    mutating func testWrappedValue() {
        #expect(wrappedValue == data1)
        wrappedValue = data2
        #expect(wrappedValue == data2)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-value",
        defaultValue: nil
    )
    var optionalValue: Data?

    @Test(.tags(.defaultValue))
    mutating func testOptionalValue() {
        #expect(optionalValue == nil)
        optionalValue = data2
        #expect(optionalValue == data2)
        optionalValue = nil
        #expect(optionalValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-value"
    )
    var optionalWrappedValue: Data? = nil

    @Test(.tags(.wrappedValue))
    mutating func testOptionalWrappedValue() {
        #expect(optionalWrappedValue == nil)
        optionalWrappedValue = data2
        #expect(optionalWrappedValue == data2)
        optionalWrappedValue = nil
        #expect(optionalWrappedValue == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "custom-data",
        transformForGetting: {
            try! JSONDecoder().decode(CustomData.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        },
        defaultValue: CustomData(value: 0)
    )
    var customData

    @Test(.tags(.defaultValue))
    mutating func testCustomData() {
        #expect(customData == CustomData(value: 0))
        customData = CustomData(value: 1)
        #expect(customData == CustomData(value: 1))
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "wrapped-custom-data",
        transformForGetting: {
            try! JSONDecoder().decode(CustomData.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var wrappedCustomData = CustomData(value: 0)

    @Test(.tags(.wrappedValue))
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
        },
        defaultValue: nil
    )
    var optionalCustomData: CustomData?

    @Test(.tags(.defaultValue))
    mutating func testOptionalCustomData() {
        #expect(optionalCustomData == nil)
        optionalCustomData = CustomData(value: 1)
        #expect(optionalCustomData == CustomData(value: 1))
        optionalCustomData = nil
        #expect(optionalCustomData == nil)
    }

    @Persisted(
        store: UserDefaults(suiteName: UUID().uuidString)!,
        key: "optional-wrapped-custom-data",
        transformForGetting: {
            try! JSONDecoder().decode(CustomData?.self, from: $0)
        },
        transformForSetting: {
            try! JSONEncoder().encode($0)
        }
    )
    var optionalWrappedCustomData: CustomData? = nil

    @Test(.tags(.wrappedValue))
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
