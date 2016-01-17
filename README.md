# TimeZoneLocate

[![CI Status](http://img.shields.io/travis/Anthony Persaud/TimeZoneLocate.svg?style=flat)](https://travis-ci.org/Anthony Persaud/TimeZoneLocate)
[![Version](https://img.shields.io/cocoapods/v/TimeZoneLocate.svg?style=flat)](http://cocoapods.org/pods/TimeZoneLocate)
[![License](https://img.shields.io/cocoapods/l/TimeZoneLocate.svg?style=flat)](http://cocoapods.org/pods/TimeZoneLocate)
[![Platform](https://img.shields.io/cocoapods/p/TimeZoneLocate.svg?style=flat)](http://cocoapods.org/pods/TimeZoneLocate)

This utility is the Swift 2.2 port of the [APTimeZones](https://github.com/Alterplay/APTimeZones) library with the support for bundled frameworks. If your project is Objective-C, we recommend using theirs.


###Usage:

```swift

    //San Diego, CA, USA
    let location = CLLocation(latitude: 32.88, longitude: -117.15)

    //NSTimeZone from extension
    var timeZone = location.timeZone
    print(timeZone)

    //or calling the class method
    timeZone = TimeZoneLocate.timeZoneWithLocation(location)
    print(timeZone)

    //if you have the country code, you can speed things up.
    timeZone = timeZoneWithLocation(location, countryCode: "US")

```

## Requirements

## Installation

To install it, simply add the following line to your Podfile:

```ruby
pod "TimeZoneLocate", git: 'https://github.com/modernistik/TimeZoneLocate.git'
```

## Authors
 * Original Objective-C Version: Sergii Kryvoblotskyi, Alterplay
 * Swift Contributor: Anthony Persaud, persaud@modernistik.com

## License

TimeZoneLocate is available under the MIT license. See the LICENSE file for more info.
