# Change Log
All notable changes to this project will be documented in this file.
`TimeZoneLocate` adheres to [Semantic Versioning](http://semver.org/).

---
## 0.5.0
* Project and spec updates for Swift 5 and Cocoapods 1.7.1

## 0.4.3
* Adds PR #8 to include WatchOS.

## 0.4.2
* Warning fixes to static properties.

## 0.4.1
* Support for Swift 4.2

## 0.4.0
* Support for Swift 4.0
* Adds extension method ` timeZone(completion:TimeZoneLocateResult)` that uses
reverse geocoding to fetch a more accurate time zone when connected to the network.

## 0.3.1
* Fixes #5: issue relating to empty country code.

## 0.3.0
* Changes to API method names to comply better with Swift 3.0.
* Fixing string warning. [Jawwad Ahmad](https://github.com/jawwad)
* Pryamid of doom code cleanup. [Mamnun Bhuiyan](https://github.com/mamnun)

## 0.2.0
* Converted syntax to support Swift 3.0 and XCode 8.2 and later. To keep using pre Swift 3.0, use:
   `pod 'TimeZoneLocate', '= 0.1.0'`

## 0.1.0
* Initial port.
