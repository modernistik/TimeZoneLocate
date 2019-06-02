# TimeZoneLocate

This utility is the Swift port of the [APTimeZones](https://github.com/Alterplay/APTimeZones) library with the support for bundled frameworks. If your project is Objective-C, we recommend using theirs.

* For Swift 5 version, use version `~> 0.5.0`.
* For Swift 4 version, use version `~> 0.4.0`.
* For Swift 3 version, use version `~> 0.3.0`.
* For Swift 2 version, use version `~> 0.1.0`.

### Usage:

```swift

    //San Diego, CA, USA
    let location = CLLocation(latitude: 32.88, longitude: -117.15)

    //TimeZone from extension (fast, synchronous, approximate)
    var timeZone = location.timeZone
    print(timeZone)

    //or calling the class method
    timeZone = TimeZoneLocate.timeZone(location: location)
    print(timeZone)

    //if you have the country code, you can speed things up.
    timeZone = TimeZoneLocate.timeZone(location: location, countryCode: "US")

    // A MORE accurate time zone if you are connected to network. (iOS 9.0 or later)
    location.timeZone { (tz) -> (Void) in
      guard let tz = tz else { return }
      // got a more accureate timezone from the network
      print("Network TimeZone: \(tz.identifier)")
    }

    // Same thing
    TimeZoneLocate.geocodeTimeZone(location: location) { (tz) -> (Void) in
      guard let tz = tz else { return }
      print("Network TimeZone: \(tz.identifier) (class method)")
    }

```

## Installation

To install it, simply add the following line to your Podfile:

```ruby
pod "TimeZoneLocate"
```

## Authors
 * Original Objective-C Version: Sergii Kryvoblotskyi, Alterplay
 * Swift Contributor: Anthony Persaud, persaud@modernistik.com (https://www.modernistik.com)

## License

TimeZoneLocate is available under the MIT license. See the LICENSE file for more info.
