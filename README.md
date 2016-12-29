# TimeZoneLocate

This utility is the Swift 3.0 port of the [APTimeZones](https://github.com/Alterplay/APTimeZones) library with the support for bundled frameworks. If your project is Objective-C, we recommend using theirs.

To continue using Swift 2.2 version, use version `0.1.0`.

###Usage:

```swift

    //San Diego, CA, USA
    let location = CLLocation(latitude: 32.88, longitude: -117.15)

    //TimeZone from extension
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
pod "TimeZoneLocate"
```

## Authors
 * Original Objective-C Version: Sergii Kryvoblotskyi, Alterplay
 * Swift Contributor: Anthony Persaud, persaud@modernistik.com

## License

TimeZoneLocate is available under the MIT license. See the LICENSE file for more info.
