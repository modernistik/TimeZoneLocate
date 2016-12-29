//: Playground - noun: a place where people can play

import UIKit
import MapKit
import TimeZoneLocate

var str = "Hello, NSTimeZone!"

let location = CLLocation(latitude: 32.88, longitude: -117.15)
//helper method
let theTimeZone = location.timeZone
print("TimeZone: \(theTimeZone.identifier)")
// Or the shared method
let timeZone = TimeZoneLocate.timeZoneWithLocation(location)
print(timeZone)

let geocoder = CLGeocoder()
geocoder.geocodeAddressString("San Diego, CA") { (placemarks, error) -> Void in
    if error == nil, let placemarks = placemarks, let placemark = placemarks.first {
        
        let locationTimeZone = placemark.location?.timeZone
        print(locationTimeZone!)
        //of if country code is known, then
        if let location = placemark.location, let countryCode = placemark.addressDictionary?["CountryCode"] as? String {
            let fastTimeZone = TimeZoneLocate.timeZoneWithLocation(location, countryCode: countryCode)
            print(fastTimeZone!)
        }
        
        //Helper method
        
    }
}
