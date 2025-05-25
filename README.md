# Persistence

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/treastrain/Adaption/blob/main/LICENSE)
![Platform: iOS & iPadOS|macOS|tvOS|watchOS|visionOS|Linux|Windows](https://img.shields.io/badge/Platform-iOS%20%26%20iPadOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20visionOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)
![Swift: 6.0](https://img.shields.io/badge/Swift-6.0-orange.svg)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) \
[![X (formerly Twitter): @treastrain](https://img.shields.io/twitter/follow/treastrain?label=%40treastrain&style=social)](https://x.com/treastrain)
[![Swift Build & Test](https://github.com/treastrain/Persistence/actions/workflows/swift.yml/badge.svg)](https://github.com/treastrain/Persistence/actions/workflows/swift.yml)

- ✅ Key-Value store
- ✅ Customizable datastore base (e.g. `UserDefaults`)
- ✅ Type-safe
- ✅ Concurrency-safe (`Sendable`)
- ✅ Observable (Combine, `for-await-in` loop & `NotificationCenter`)

# Usage

```swift
import Foundation
import Persistence

enum UserDefaultsKeys: String, UserDefaultsKey {
    case numberKeyName
    case stringKeyName
}

@Persisted(
    key: UserDefaultsKeys.numberKeyName
)
var number = 0

@Persisted(
    store: UserDefaults(suiteName: "jp.tret.example-app.custom-suite")!,
    key: UserDefaultsKeys.stringKeyName
)
var string = ""
```

# How to add to your project
## Package dependencies
```swift
.package(url: "https://github.com/treastrain/Persistence", from: "0.7.0"),
```

## Target dependencies
```swift
.product(name: "Persistence", package: "Persistence"),
```

# License
MIT
