//: Playground - noun: a place where people can play

import UIKit
import MapKit
import TimeZoneLocate
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
var str = "Hello, TimeZone!"

let location = CLLocation(latitude: 32.88, longitude: -117.15)
//helper method
let theTimeZone = location.timeZone
print("TimeZone: \(theTimeZone.identifier)")
// Or the shared method
let timeZone = TimeZoneLocate.timeZoneWithLocation(location)
print(timeZone)

location.timeZone { (tz) -> (Void) in
    guard let tz = tz else { return }
    print("Network TimeZone: \(tz.identifier)")
    // got a more accureate timezone from the network
}

TimeZoneLocate.geocodeTimeZone(location: location) { (tz) -> (Void) in

}
let geocoder = CLGeocoder()
geocoder.geocodeAddressString("San Diego, CA") { (placemarks, error) -> Void in
    if error == nil, let placemarks = placemarks,
                     let placemark = placemarks.first,
                     let locationTimeZone = placemark.location?.timeZone {
        
        print(locationTimeZone)
        //of if country code is known, then
        if let location = placemark.location, let countryCode = placemark.isoCountryCode,
            let fastTimeZone = TimeZoneLocate.timeZone(location: location, countryCode: countryCode) {
            print(fastTimeZone)
        }
        
    }
}
